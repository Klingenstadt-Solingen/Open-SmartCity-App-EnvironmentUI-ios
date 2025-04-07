import OSCAEssentials
import Foundation

public final class OSCAEnvironmentFlowCoordinator: Coordinator {
    /**
     `children`property for conforming to `Coordinator` protocol is a list of `Coordinator`s
     */
    public var children: [Coordinator] = []
    
    /**
     router injected via initializer: `router` will be used to push and pop view controllers
     */
    public let router: Router
    /**
     environment station view controller `OSCAEnvironmentMainViewController`
     */
    weak var environmentStationVC: OSCAEnvironmentMainViewController?
    
    public init(router: Router) {
        self.router = router
    }
    
    public func showEnvironmentMain(animated: Bool, url: String?, clientKey: String?, appId: String?, sessionToken: String?,
                             onDismissed: (() -> Void)?) -> Void {
        OSCAEnvironmentSettings.initParse(url: url, clientKey: clientKey, appId: appId, sessionToken: sessionToken)
        let vc = OSCAEnvironmentMainViewController.create()
        self.router.present(vc,
                            animated: animated,
                            onDismissed: onDismissed)
        self.environmentStationVC = vc
    }// end func showEnvironmentMain
    
    public func present(animated: Bool, onDismissed: (() -> Void)?) {
        // Unused but needed to conform to Coordinator
    }// end public func present
}
