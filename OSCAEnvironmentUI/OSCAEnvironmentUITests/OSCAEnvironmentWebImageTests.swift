import XCTest
import ViewInspector
@testable import OSCAEnvironmentUI

final class OSCAEnvironmentWebImageTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        
    }

    override func tearDownWithError() throws {
    }
    
    /**
     Tests if WebImage exists
     */
    func testWebImageExist() throws {
        let url = "https://source.unsplash.com/user/c_v_r/100x100"
        let webImage = OSCAEnvironmentWebImage(url: url)
        let imageAbsent = try webImage.inspect().isAbsent
        
        XCTAssert(!imageAbsent) // check if webimage is not absent
    }
}

extension OSCAEnvironmentWebImage: Inspectable {}
