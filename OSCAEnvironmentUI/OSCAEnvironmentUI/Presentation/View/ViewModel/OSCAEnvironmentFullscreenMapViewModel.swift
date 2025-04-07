import SwiftUI
import MapKit

class OSCAEnvironmentFullscreenMapViewModel: OSCAEnvironmentLoadable {
    @Published var stations = [EnvironmentStation]()
    
    func fetchStations(_ region: MKCoordinateRegion) async {
        await errorNoLoadingState {
            let result = try await OSCAEnvironmentStationRepositoryImpl.getStationsByBounds(region: region)
            await MainActor.run {
                stations.removeAll()
                stations = result
            }
        }
    }
}
