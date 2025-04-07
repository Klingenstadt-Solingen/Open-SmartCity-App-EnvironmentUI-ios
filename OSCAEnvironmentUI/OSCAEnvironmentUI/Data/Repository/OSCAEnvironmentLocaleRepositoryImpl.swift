import ParseCore

/**
 Repository for fetching locales
 */
struct OSCAEnvironmentLocaleRepositoryImpl: OSCAEnvironmentLocaleRepository {
    
    static func getLocaleByLanguageAndKey(language: String, key: String) async throws -> EnvironmentLocale? {
        let query = EnvironmentLocale.query()!.whereKey("locale", equalTo: language).whereKey("key", equalTo: key)
        query.maxCacheAge = OSCAEnvironmentSettings.shared.maxLocaleCacheAge
        query.cachePolicy = .cacheElseNetwork
        
        do {
            return try catchParse { try query.getFirstObject() }
        } catch {
            if let error = error as? ApiError {
                switch (error) {
                case.NoResult:
                    return nil
                default:
                    throw error
                }
            }
            throw error
        }
    }
    
    static func getLocalesByLanguage(language: String, cachePolicy: PFCachePolicy) async throws -> [EnvironmentLocale] {
        let query = EnvironmentLocale.query()!.whereKey("locale", equalTo: language)
        query.maxCacheAge = OSCAEnvironmentSettings.shared.maxLocaleCacheAge
        query.cachePolicy = cachePolicy
        query.limit = 10_000 // TODO: INCREMENTAL REQUEST
        
        do {
            return try catchParse { try query.findObjects() }
        } catch {
            if let error = error as? ApiError {
                switch (error) {
                case.NoResult:
                    return []
                default:
                    throw error
                }
            }
            if let error = error as? ParseError {
                if error.localizedDescription == "no_result" {
                    return []
                }
            }
            throw error
        }
    }
}
