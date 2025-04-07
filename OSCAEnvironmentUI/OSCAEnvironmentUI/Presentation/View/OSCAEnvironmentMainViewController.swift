import OSCAEssentials
import UIKit
import SwiftUI

/**
 Main ViewController for the Environment Module
 */
public final class OSCAEnvironmentMainViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        initializeEnvironmentView()
    }
    
    /**
     Initializes the SwiftUI View by creating a UIHostingController and adding it as a subview of the main ViewController
     */
    private func initializeEnvironmentView() {
        let _ = OSCAEnvironmentSettings.shared // Initializes Parse Client
        let mainViewVC = UIHostingController(rootView: OSCAEnvironmentMainView()
            .environmentObject(OSCAEnvironmentNavigator())
            .environmentObject(OSCAEnvironmentLocaleViewModel()))
        addChild(mainViewVC)
        mainViewVC.view.frame = view.bounds
        view.addSubview(mainViewVC.view)
        // Making the subview fill the maximum available space
        mainViewVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainViewVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainViewVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainViewVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            mainViewVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        mainViewVC.didMove(toParent: self)
    }
}

extension OSCAEnvironmentMainViewController: StoryboardInstantiable {
    public static func create() -> OSCAEnvironmentMainViewController {
        let vc = Self.instantiateViewController(OSCAEnvironmentUI.bundle)
        
        return vc
    }
}
