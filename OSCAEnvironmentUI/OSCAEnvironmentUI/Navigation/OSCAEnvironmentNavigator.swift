import SwiftUI

/**
 Object used for handling navigation
 */
class OSCAEnvironmentNavigator: ObservableObject {
    @Published var navRoute: EnvNavigationRoute = .emptyRoute
    @Published var navStack: Array<EnvNavigationRoute> = []
    
    func navigate(route: EnvNavigationRoute, replace: Bool = false) {
        withAnimation(.linear) {
            if !replace { navStack.append(navRoute) }
            navRoute = route
        }
    }
    
    func navigateBack() {
        if navStack.count > 0 {
            withAnimation(.linear) {
                navRoute = navStack.last!
                navStack.removeLast()
            }
        }
        else {
            print("navStack is empty, cannot navigate back")
        }
    }
}
