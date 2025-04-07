import Foundation
import ParseCore

/**
 Responsible for fetching a graph data
 */
class OSCAEnvironmentGraphViewModel: OSCAEnvironmentLoadable {
    @Published var graphData = [EnvironmentSensorValue]()
    
    func fetchGraphData(refId: String) async {
        await errorToLoadingState {
            let result = try await OSCAEnvironmentSensorRepositoryImpl.getSensorValuesByRefId(refId: refId)
            await MainActor.run {
                graphData = result
            }
        }
    }
    
}
