import Foundation
import SwiftUI


class OSCAEnvironmentSensorFavViewModel: OSCAEnvironmentLoadable {
    @Published var favSensors: [EnvironmentSensor] = []

    private static var favSenorKey = "favSensors"
    
    private func getFavSensorIds() ->  Set<String> {
        let ids = try? UserDefaults.standard.getObject(forKey: OSCAEnvironmentSensorFavViewModel.favSenorKey, castTo: Set<String>.self)
        return ids ?? Set()
    }
    
    private func setFavSensorIds(_ objectIds: Set<String>) {
        try? UserDefaults.standard.setObject(objectIds, forKey: OSCAEnvironmentSensorFavViewModel.favSenorKey)
    }
    
    func toggleFavSensor(objectId: String, sensor: EnvironmentSensor? = nil) {
        objectWillChange.send()
        var sensorIds = getFavSensorIds()
        
        if sensorIds.contains(objectId) {
            sensorIds.remove(objectId)
            favSensors.removeAll { sensor in
                sensor.objectId == objectId
            }
        } else {
            sensorIds.insert(objectId)
            if let sensor {
                if !(favSensors.contains { sensor in
                    sensor.objectId == objectId
                }) {
                    favSensors.append(sensor)
                }
            }
        }
        setFavSensorIds(sensorIds)
    }
    
    func getFavSensors() async {
        await errorToLoadingState(noResult: "no_fav_sensor") {
            let sensorIds = getFavSensorIds()

            let favSensors = try await OSCAEnvironmentSensorRepositoryImpl.getSensorByIds(sensorIds: Array(sensorIds))
            await MainActor.run {
                self.favSensors = favSensors
            }
        }
    }
    
    func isFavSensor(objectId: String) -> Bool {
        return getFavSensorIds().contains(objectId)
    }
}
