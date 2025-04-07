import OSCAEssentials
import UIKit
import SwiftUI

/**
 Main ViewController for the Environment Module
 */
public final class OSCAEnvironmentWidgetViewController: UIViewController {

    public init(url: String?, clientKey: String?, appId: String?, sessionToken: String?) {
        OSCAEnvironmentSettings.initParse(url: url, clientKey: clientKey, appId: appId, sessionToken: sessionToken)
        super.init(nibName: nil, bundle: OSCAEnvironmentUI.bundle)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        initializeEnvironmentWidgetView()
    }
    
    /**
     Initializes the SwiftUI View by creating a UIHostingController and adding it as a subview of the main ViewController
     */
    private func initializeEnvironmentWidgetView() {
        let widgetVC = UIHostingController(rootView: OSCAEnvironmentWidgetView())
        addChild(widgetVC)
        widgetVC.view.frame = view.bounds
        view.addSubview(widgetVC.view)
        // Making the subview fill the maximum available space
        widgetVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widgetVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            widgetVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            widgetVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            widgetVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        widgetVC.didMove(toParent: self)
    }
}
