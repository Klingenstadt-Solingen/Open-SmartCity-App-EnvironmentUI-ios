import ParseCore

protocol OSCAEnvironmentSensorRepository {
    
    static func getSensorById(sensorId: String) async throws -> EnvironmentSensor?
    static func getSensorByIds(sensorIds: [String]) async throws -> [EnvironmentSensor]
    static func getSensorsByStationAndSubCategoryId(stationId: String, subCategoryId: String?, skip: Int) async throws -> [EnvironmentSensor]
    static func getSensorValuesByRefId(refId: String) async throws -> [EnvironmentSensorValue]
}
