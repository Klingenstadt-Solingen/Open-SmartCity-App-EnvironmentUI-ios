import XCTest
import ViewInspector
@testable import OSCAEnvironmentUI

final class OSCAEnvironmentSubtitleTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        
    }

    override func tearDownWithError() throws {
    }
    
    /**
     Tests if Subtitle Title is visible
     */
    func testSubtitleTitle() throws {
        let title = "testTitle"
        let subTitle = OSCAEnvironmentSubtitle(subtitle: title)
        let subTitleString = try subTitle.inspect().hStack().find(ViewType.Text.self).string()
        
        XCTAssertEqual(subTitleString,title) // compare extracted string with title
    }
}

extension OSCAEnvironmentSubtitle: Inspectable {}
