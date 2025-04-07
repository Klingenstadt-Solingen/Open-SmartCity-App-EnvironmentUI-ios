import XCTest
import ViewInspector
import SwiftUI
@testable import OSCAEnvironmentUI

final class OSCAEnvironmentLoadingWrapperTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        
    }

    override func tearDownWithError() throws {
    }
    
    /**
     Tests if Progress View is visible
     */
    func testLoading() throws {
        let loadable = OSCAEnvironmentLoadable()
        loadable.loadingState = .loading
        let wrapper = OSCAEnvironmentLoadingWrapper(loadable: [loadable]) {
            Text("content")
        }
        let loadingAbsent = try wrapper.inspect().find(ViewType.ProgressView.self).isAbsent
        
        XCTAssert(!loadingAbsent) // checks if progressview exists
    }
    
    /**
     Tests if Content is visible
     */
    func testLoaded() throws {
        let contentTitle = "content"
        let loadable = OSCAEnvironmentLoadable()
        loadable.loadingState = .loaded
        let wrapper = OSCAEnvironmentLoadingWrapper(loadable: [loadable]) {
            Text("content")
        }
        let content = try wrapper.inspect().find(ViewType.Text.self).string()
        
        XCTAssertEqual(contentTitle, content) // compares contentTitle with text title
    }
    
    /**
     Tests if Error is visible
     */
    func testError() throws {
        let errorMessage = "error"
        let loadable = OSCAEnvironmentLoadable()
        loadable.loadingState = .error(error: "error")
        let wrapper = OSCAEnvironmentLoadingWrapper(loadable: [loadable]) {
            Text("content")
        }
        let error = try wrapper.inspect().find(ViewType.Text.self).string()
        
        XCTAssertEqual(errorMessage, error) // compares contentTitle with text title
    }
    
    /**
     Tests if clicking the try again button works
     */
    func testTryAgain() throws {
        var tryAgainClicked = false
        let loadable = OSCAEnvironmentLoadable()
        loadable.loadingState = .error(error: "error")
        let wrapper = OSCAEnvironmentLoadingWrapper(loadable: [loadable], tryAgain: {
            tryAgainClicked = true
        }) {
            Text("content")
        }
        try wrapper.inspect().find(ViewType.Button.self).tap()
        
        XCTAssert(tryAgainClicked) // check if the try again button was clicked
    }
}

extension OSCAEnvironmentLoadingWrapper: Inspectable {}
