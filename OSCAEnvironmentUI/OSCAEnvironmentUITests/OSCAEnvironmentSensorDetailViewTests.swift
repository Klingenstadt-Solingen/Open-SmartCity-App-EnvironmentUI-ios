import XCTest
import ViewInspector
@testable import OSCAEnvironmentUI

final class OSCAEnvironmentSensorDetailViewTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        
    }

    override func tearDownWithError() throws {
    }
    
    /**
     Tests if EnvironmentSensorDetailView exists
     */
    func testSensorDetailViewExists() throws {
        let mockVM = MockedSensorDetailVM(.loading)
        let sensorDetailView = OSCAEnvironmentSensorDetailView(sensorDetailVM: mockVM, backButtonKey: "", subtitle: "", sensorId: "").environmentObject(OSCAEnvironmentNavigator()).environmentObject(mockLocaleVM())
        let sensorDetailViewAbsent = try sensorDetailView.inspect().isAbsent
        XCTAssert(!sensorDetailViewAbsent) // checks if the sensor detail view is not absent
    }
}

extension OSCAEnvironmentSensorDetailView: Inspectable {}

extension OSCAEnvironmentSensorDetailViewTests {
    
    func mockLocaleVM() -> OSCAEnvironmentLocaleViewModel {
        return MockedLocaleVM()
    }
    
    class MockedLocaleVM: OSCAEnvironmentLocaleViewModel {
        override func getLocaleForKey(_ key: String) -> String {
            "mockedkey"
        }
    }
    
    class MockedSensorDetailVM: OSCAEnvironmentSensorDetailViewModel {
        init(_ loadState: LoadingState = .loading) {
            super.init()
            self.loadingState = loadState
        }
        
        override func initFetch(sensorId: String) {
            
        }
        override func fetchValue(sensorId: String) async {
            
        }
        override func fetchGraphData(refId: String) async {
            
        }
    }
}


