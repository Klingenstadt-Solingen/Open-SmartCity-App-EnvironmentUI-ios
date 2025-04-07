import XCTest
import ViewInspector
@testable import OSCAEnvironmentUI

final class OSCAEnvironmentGraphTests: XCTestCase {
    var parseInit = ParseInit.shared

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }
    
    /**
     Tests if Graph exists
     */
    func testGraphExist() throws {
        let graph = OSCAEnvironmentGraph(data: mockSensorValues(), availableWidth: 400, height: 400)
        let graphAbsent = try graph.inspect().isAbsent
        
        XCTAssert(!graphAbsent) // checks if graph is not absent
    }
    
    /**
     Tests if there as many subviews as expected
     */
    func testGraphSubviews() throws {
        let graph = try OSCAEnvironmentGraph(data: mockSensorValues(), availableWidth: 400, height: 400).inspect().vStack().hStack(0).zStack(1)
        
        XCTAssert(graph.count == 3) // OSCAEnvironmentGraphGradientShape, OSCAEnvironmentGraphShape, OSCAEnvironmentCartesianShape expected
    }
}

extension OSCAEnvironmentGraph: Inspectable {}
extension OSCAEnvironmentGraphTests {
    func mockSensorValues() -> [EnvironmentSensorValue] {
        var data = [EnvironmentSensorValue]()
        for i in 0..<10 {
            let value = EnvironmentSensorValue()
            value.value = Double(i)
            value.observedAt = Date.now
            data.append(value)
        }
        
        return data
    }
}
