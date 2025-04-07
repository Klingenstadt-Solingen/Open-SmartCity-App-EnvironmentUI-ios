import Foundation

/**
 Responsible for fetching Sensors
 */
class OSCAEnvironmentSensorViewModel: OSCAEnvironmentLoadable {
    @Published var sensors = [EnvironmentSensor]()
    
    func fetchSensors(stationId: String, subCategoryId: String?) async {
        await errorToLoadingState {
            let result = try await OSCAEnvironmentSensorRepositoryImpl.getSensorsByStationAndSubCategoryId(stationId: stationId, subCategoryId: subCategoryId, skip: 0)
            await MainActor.run {
                sensors = result
            }
        }
    }
    
    func fetchMoreSensors(stationId: String, subCategoryId: String?) async {
        await errorNoLoadingState {
            let result = try await OSCAEnvironmentSensorRepositoryImpl.getSensorsByStationAndSubCategoryId(stationId: stationId, subCategoryId: subCategoryId, skip: sensors.endIndex)
            await MainActor.run {
                sensors.append(contentsOf: result)
            }
        }
    }
}
