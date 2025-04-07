import XCTest
import ViewInspector
@testable import OSCAEnvironmentUI

final class OSCAEnvironmentBackButtonTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        
    }

    override func tearDownWithError() throws {
    }
    
    /**
     Tests if Backbutton Title is visible
     */
    func testbackButtonKey() throws {
        let title = "testTitle"
        let button = OSCAEnvironmentBackButton(backButtonKey: title).environmentObject(OSCAEnvironmentNavigator())
        let backTitle = try button.inspect().view(OSCAEnvironmentBackButton.self).hStack().button(0).labelView().hStack().find(ViewType.Text.self).string()
        
        XCTAssertEqual(backTitle,title) // compare extracted string with title
    }
    
    /**
     Tests if Image exsists
     */
    func testBackbuttonImage() throws {
        let button = OSCAEnvironmentBackButton(backButtonKey: "testTitle").environmentObject(OSCAEnvironmentNavigator())
        let image = try button.inspect().view(OSCAEnvironmentBackButton.self).hStack().button(0).labelView().hStack().find(ViewType.Image.self).isAbsent
        
        XCTAssert(!image) // check if image is not absent
    }
    
    /**
     Test if Backbutton Action works
     */
    func testBackbuttonAction() throws {
        let navigator = OSCAEnvironmentNavigator()
        navigator.navigate(route: .emptyRoute) // add empty route to backstack
        navigator.navigate(route: .sensorDetailRoute(backButtonKey: "", subtitle: "", sensorId: "")) // add detail route to backstack
        
        var routeIsDetail = false
        switch navigator.navRoute {
        case .sensorDetailRoute(_, _, _):
            routeIsDetail = true
        default:
            routeIsDetail = false
        }
        XCTAssert(routeIsDetail) // check if route is detail
        
        let button = OSCAEnvironmentBackButton(backButtonKey: "testTitle").environmentObject(navigator)
        try button.inspect().view(OSCAEnvironmentBackButton.self).hStack().button(0).tap()
        
        var routeIsEmpty = false
        switch navigator.navRoute {
        case .emptyRoute:
            routeIsEmpty = true
        default:
            routeIsEmpty = false
        }
        
        XCTAssert(routeIsEmpty) // check if route is empty
    }
}

extension OSCAEnvironmentBackButton: Inspectable {}
