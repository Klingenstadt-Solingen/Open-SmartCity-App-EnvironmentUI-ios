import XCTest
import ViewInspector
@testable import OSCAEnvironmentUI

final class OSCAEnvironmentMapTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        
    }

    override func tearDownWithError() throws {
    }
    
    /**
     Tests if EnvironmentMap exists
     */
    func testMapTitle() throws {
        let map = OSCAEnvironmentMap(region: createRegion())
        let mapAbsent = try map.inspect().isAbsent
        
        XCTAssert(!mapAbsent) // check map exists
    }
}

extension OSCAEnvironmentMap: Inspectable {}
