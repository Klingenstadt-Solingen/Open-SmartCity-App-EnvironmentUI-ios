import MapKit

/**
 Responsible for fetching Stations for the Map
 */
class OSCAEnvironmentStationMapViewModel: OSCAEnvironmentLoadable {
    @Published var stations = [EnvironmentStation]()
    
    func fetchStations(subCategoryId: String, region: MKCoordinateRegion) async {
        await errorNoLoadingState {
            let result = try await OSCAEnvironmentStationRepositoryImpl.getStationsByBoundsAndSubCategoryId(subCategoryId: subCategoryId, region: region)
            await MainActor.run {
                stations.removeAll()
                stations = result
            }
        }
    }
}
