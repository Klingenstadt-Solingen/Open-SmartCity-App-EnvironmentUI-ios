import Foundation

/**
 Responsible for fetching a Sensor
 */
class OSCAEnvironmentSensorDetailViewModel: OSCAEnvironmentLoadable {
    @Published var sensor: EnvironmentSensor?
    
    func fetchValue(sensorId: String) async {
        await errorToLoadingState {
            let result = try await OSCAEnvironmentSensorRepositoryImpl.getSensorById(sensorId: sensorId)
            await MainActor.run {
                sensor = result
            }
        }
    }
}
