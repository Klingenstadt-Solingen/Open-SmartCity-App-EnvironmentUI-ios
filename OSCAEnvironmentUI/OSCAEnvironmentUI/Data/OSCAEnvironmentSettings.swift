import ParseCore
import SDWebImageSwiftUI
import SDWebImageSVGCoder

/**
 Singleton used to initialize parse a.o.
 */
public class OSCAEnvironmentSettings {
    public static let shared = OSCAEnvironmentSettings()
    let maxCacheAge = 600.0
    let maxLocaleCacheAge = 28800.0
    let queryLimit = 50
    let queryMax = 10000
    var sessionToken: String? = "nil"
    
    /**
     Initializes Parse
     */
    static func initParse(url: String?, clientKey: String?, appId: String?, sessionToken: String?) {
        OSCAEnvironmentSettings.shared.sessionToken = sessionToken
        if ((Parse.currentConfiguration) == nil) {
            if let key = clientKey, let url = url, let id = appId {
                let parseConfig = ParseClientConfiguration { config in
                    config.applicationId = id
                    config.clientKey = key
                    config.server = url
                }
                Parse.initialize(with: parseConfig)
            }
            let SVGCoder = SDImageSVGCoder.shared
            SDImageCodersManager.shared.addCoder(SVGCoder)
        }

        if let currentUser = PFUser.current() {
            if let sessionToken = sessionToken {
                if currentUser.sessionToken != sessionToken {
                    do {
                        try PFUser.become(sessionToken)
#if DEBUG
                        print("Switched to user with new session token.")
#endif
                        OSCAEnvironmentSettings.shared.sessionToken = sessionToken
                    } catch (let err) {
#if DEBUG
                        print(err)
                        print("Unable to switch to user with new session token.")
#endif
                        if PFUser.current() == nil {
#if DEBUG
                            print("Performing anonymous login.")
#endif
                            PFAnonymousUtils.logIn()
                        }
                        OSCAEnvironmentSettings.shared.sessionToken = PFUser.current()?.sessionToken
                    }
                }
            }
        } else {
            if let sessionToken = sessionToken {
                do {
                    try PFUser.become(sessionToken)
#if DEBUG
                    print("Logged in with session token.")
#endif
                    OSCAEnvironmentSettings.shared.sessionToken = sessionToken
                } catch (let err) {
#if DEBUG
                    print(err)
                    print("Unable to login with session token.")
#endif
                    PFAnonymousUtils.logIn()
                }
            } else {
#if DEBUG
                print("No session token found. Performing anonymous login.")
#endif
                PFAnonymousUtils.logIn()
            }
            OSCAEnvironmentSettings.shared.sessionToken = PFUser.current()?.sessionToken
        }
    }
}
