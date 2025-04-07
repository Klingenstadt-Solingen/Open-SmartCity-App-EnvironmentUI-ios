import OSCAEssentials
import Foundation

public struct OSCAEnvironmentDependencies {
    let moduleConfig: OSCAEnvironmentConfig
    
    public init(moduleConfig: OSCAEnvironmentConfig) {
        self.moduleConfig   = moduleConfig
    }
}

public struct OSCAEnvironmentConfig {
    /// module title
    public var title: String?
    /// app deeplink scheme URL part before `://`
    public var deeplinkScheme: String = "solingen"
    
    public init(title: String?,
                deeplinkScheme: String = "solingen") {
        self.title = title
        self.deeplinkScheme = deeplinkScheme
    }
}

public struct OSCAEnvironmentUI {
    public var version: String = "0.9.0"
    public var bundlePrefix: String = "de.nedeco-osca.environment.ui"
    
    public internal(set) static var configuration: OSCAEnvironmentConfig!
    /// module `Bundle`x
    ///
    /// **available after module initialization only!!!**
    
#if SWIFT_PACKAGE
    public internal(set) static var bundle: Bundle! = Bundle.module
#else
    public internal(set) static var bundle: Bundle!
#endif
    
    /**
     create module and inject module dependencies
     - Parameter mduleDependencies: module dependencies
     */
    public static func create(with moduleDependencies: OSCAEnvironmentDependencies) -> OSCAEnvironmentUI {
        var module: Self = Self.init(config: moduleDependencies.moduleConfig)
        return module
    }
    
    /// public initializer with module configuration
    /// - Parameter config: module configuration
    public init(config: OSCAEnvironmentConfig) {
#if SWIFT_PACKAGE
        Self.bundle = Bundle.module
#else
        guard let bundle: Bundle = Bundle(identifier: self.bundlePrefix) else { fatalError("Module bundle not initialized!") }
        Self.bundle = bundle
#endif
        OSCAEnvironmentUI.configuration = config
    }
    
    /**
     public module interface `getter`for `OSCAEnvironmentStationFlowCoordinator`
     - Parameter router: router needed or the navigation graph
     */
    public func getEnvironmentFlowCoordinator(router: Router) -> OSCAEnvironmentFlowCoordinator {
        let flow = OSCAEnvironmentFlowCoordinator(router: router)
        return flow
    }
}
