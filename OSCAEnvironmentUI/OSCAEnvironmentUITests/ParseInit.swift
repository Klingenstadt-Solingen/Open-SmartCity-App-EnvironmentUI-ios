import ParseCore
@testable import OSCAEnvironmentUI

class ParseInit {
    static let shared = ParseInit()
    
    init(){
        initialize()
    }

    private func initialize() {
        EnvironmentSensorValue.registerSubclass()
        let parseConfig = ParseClientConfiguration { config in
            config.applicationId = "aa"
            config.clientKey = "aa"
            config.server = "aa"
        }
        Parse.initialize(with: parseConfig)
    }
}
