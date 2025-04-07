import ParseCore

/**
 Repository for fetching sensors
 */
struct OSCAEnvironmentSensorRepositoryImpl: OSCAEnvironmentSensorRepository {
    
    static func getSensorById(sensorId: String) async throws -> EnvironmentSensor? {
        let query = EnvironmentSensor.query()!
            .includeKey("sensorType")
            .includeKey("station.poi")
            .includeKey("sensorType.icon")
        query.maxCacheAge = OSCAEnvironmentSettings.shared.maxCacheAge
        query.cachePolicy = .cacheElseNetwork
        
        return try catchParse { try query.getObjectWithId(sensorId) }
    }
    
    static func getSensorByIds(sensorIds: [String]) async throws -> [EnvironmentSensor] {
        let query = EnvironmentSensor.query()!
            .includeKey("sensorType")
            .includeKey("station.poi")
            .includeKey("sensorType.icon")
        
        query.whereKey("objectId", containedIn: sensorIds)
        query.maxCacheAge = OSCAEnvironmentSettings.shared.maxCacheAge
        query.cachePolicy = .cacheElseNetwork
        query.limit = OSCAEnvironmentSettings.shared.queryMax // get all if possible
        
        return try catchParse { try query.findObjects() }
    }
    
    static func getSensorsByStationAndSubCategoryId(stationId: String, subCategoryId: String?, skip: Int) async throws -> [EnvironmentSensor] {
        let query = EnvironmentSensor.query()!
        if let subCategoryId = subCategoryId {
            let subCategoryQuery = EnvironmentSubCategory(withoutDataWithObjectId: subCategoryId).relation(forKey: "sensorTypes").query()
            let typeQuery = EnvironmentSensorType.query()!.whereKey("objectId", matchesQuery: subCategoryQuery)
            query.whereKey("sensorType", matchesQuery: typeQuery)
        }
        query.whereKey("station", equalTo: stationId)
        query.includeKey("sensorType")
            .includeKey("station")
            .includeKey("sensorType.icon")
        query.maxCacheAge = OSCAEnvironmentSettings.shared.maxCacheAge
        query.cachePolicy = .cacheElseNetwork
        query.limit = OSCAEnvironmentSettings.shared.queryLimit
        query.skip = skip
        
        return try catchParse { try query.findObjects() }
    }
    
    static func getSensorValuesByRefId(refId: String) async throws -> [EnvironmentSensorValue] {
        var params = EnvironmentSensorHistoryQuery(refId: refId, limit: 60, skip: 0)

        return try await callParseFunction("environmentSensorHistory", params: params)
    }
}
