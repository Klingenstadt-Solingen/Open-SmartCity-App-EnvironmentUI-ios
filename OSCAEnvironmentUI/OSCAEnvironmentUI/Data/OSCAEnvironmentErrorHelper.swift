import ParseCore
import OSLog

/**
 Catches errors while executing aquery
 */
func catchParse<T, O>(_ block: () throws -> O) throws -> T {
    do {
        let result = try block()
        if let result = result as? T {
            return result
        } else {
            throw ParseError(description: "cast_error")
        }
    } catch {
        throw error.getError()
    }
}

/**
 Catches errors while executing array query
 */
func catchParse<T, O>(_ block: () throws  -> [O]) throws -> [T] {
    do {
        let result = try block()
        if let result = result as? [T] {
            if result.isEmpty {
                throw ParseError(description: "no_result")
            } else {
                return result
            }
        } else {
            throw ParseError(description: "cast_error")
        }
    } catch {
        throw error.getError()
    }
}

/**
 Catches errors while executing cloud function
 */
func callParseFunction<T: Decodable, P: Encodable>(_ name: String, params: P ) async throws -> T {
    // Check if url is valid and append "/" if needed
    guard let parseConfig = Parse.currentConfiguration, let url = URL(string: "\(parseConfig.server.last == "/" ? parseConfig.server : parseConfig.server + "/")functions/\(name)" ) else {
        throw ApiError.ConnectionError
    }
    let bodyData = try? JSONEncoder().encode(params)
    var urlRequest = URLRequest(url: url)
    urlRequest.cachePolicy = .useProtocolCachePolicy
    urlRequest.timeoutInterval = 60
    urlRequest.httpMethod = "POST"
    urlRequest.httpBody = bodyData
    urlRequest.setValue(parseConfig.applicationId, forHTTPHeaderField: "X-Parse-Application-Id")
    urlRequest.setValue(parseConfig.clientKey, forHTTPHeaderField: "X-Parse-Client-Key")
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    // Not required right now, but will be needed once permissions for this cloud function are implemented
    urlRequest.setValue(OSCAEnvironmentSettings.shared.sessionToken, forHTTPHeaderField: "X-Parse-Session-Token")

    let (data, response) = try await URLSession.shared.data(for: urlRequest)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
#if DEBUG
        print(response,data, urlRequest)
#endif
        throw ApiError.NoResult
    }
    
    let jsonDecoder = JSONDecoder()
    
    jsonDecoder.dateDecodingStrategy = .custom({ (key) in
        let parseDate = try key.singleValueContainer().decode([String:String].self)
        if let isoString = parseDate["iso"] {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let date = formatter.date(from: isoString) {
                return date
            }
        }
        throw ApiError.CastError
    })
    
    do {
        let decodedResult = try jsonDecoder.decode([String:T].self, from: data)
        if let decodedData = decodedResult["result"] {
            return decodedData
        }
    } catch {}
    throw ApiError.CastError // in case of error or nothing is returned
}

class ParseError: Error {
    var localizedDescription: String
    
    init(description: String) {
        self.localizedDescription = description
    }
}

extension Error {
    /**
     Proccesses Error into an Error Key
     */
    func getError() -> ApiError {
        if let nsError: NSError = self as NSError? {
            logError()
            
            if nsError.domain == PFParseErrorDomain {
                switch nsError.code {
                case 100:
                    return .ConnectionError
                case 101 | 120 | 141:
                    return .NoResult
                case 124:
                    return .Timeout
                default:
                    break
                }
            }
        }
        if let parseError = self as? ParseError {
            switch(parseError.localizedDescription) {
            case "cast_error":
                return .CastError
            case "no_result":
                return .NoResult
            default:
                break
            }
        }
        return .Unknown(error: self)
    }
    
    /**
     Logs an Error
     */
    func logError() {
#if DEBUG
        guard let nsError: NSError = self as NSError? else {
            return
        }
        if let localizedDescription = nsError.userInfo[NSLocalizedDescriptionKey] as? String {
            Logger().log("\(nsError.domain) \(nsError.code): \(localizedDescription)")
        }
#endif
    }
}
