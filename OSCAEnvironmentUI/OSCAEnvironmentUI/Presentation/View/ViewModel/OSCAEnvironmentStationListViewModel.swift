import Foundation

/**
 Responsible for fetching Stations for the List
 */
class OSCAEnvironmentStationListViewModel: OSCAEnvironmentLoadable {
    @Published var stations = [EnvironmentStation]()
    
    func fetchStations(subCategoryId: String) async {
        await errorToLoadingState {
            let result = try await OSCAEnvironmentStationRepositoryImpl.getStationsBySubCategoryId(subCategoryId: subCategoryId, skip: 0)
            await MainActor.run() {
                stations = result
            }
        }
    }
    
    func fetchMoreStations(subCategoryId: String) async {
        await errorNoLoadingState {
            let result = try await OSCAEnvironmentStationRepositoryImpl.getStationsBySubCategoryId(subCategoryId: subCategoryId, skip: stations.endIndex)
            await MainActor.run() {
                stations.append(contentsOf: result)
            }
        }
    }
}
