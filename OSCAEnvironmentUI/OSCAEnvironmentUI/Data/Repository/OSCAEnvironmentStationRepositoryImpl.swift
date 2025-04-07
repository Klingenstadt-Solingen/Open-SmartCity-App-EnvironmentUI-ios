import ParseCore
import MapKit
import OSCAEssentials

/**
 Repository for fetching  stations
 */
struct OSCAEnvironmentStationRepositoryImpl: OSCAEnvironmentStationRepository {
    
    static func getStationById(stationId: String) async throws -> EnvironmentStation? {
        let query = EnvironmentStation.query()!.includeKey("poi")
        query.maxCacheAge = OSCAEnvironmentSettings.shared.maxCacheAge
        query.cachePolicy = .cacheElseNetwork
        
        return try catchParse { try query.getObjectWithId(stationId) }
    }
    
    static func getStationsBySubCategoryId(subCategoryId: String, skip: Int) async throws -> [EnvironmentStation] {
        let subCategoryQuery = EnvironmentSubCategory(withoutDataWithObjectId: subCategoryId).relation(forKey: "sensorTypes").query()
        let typeQuery = EnvironmentSensorType.query()!.whereKey("objectId", matchesQuery: subCategoryQuery)
        let sensorQuery = EnvironmentSensor.query()!.whereKey("sensorType", matchesQuery: typeQuery)
        let query = EnvironmentStation.query()!.whereKey("objectId", matchesKey: "station", in: sensorQuery)
            .includeKey("poi")
        query.maxCacheAge = OSCAEnvironmentSettings.shared.maxCacheAge
        query.cachePolicy = .cacheElseNetwork
        query.limit = OSCAEnvironmentSettings.shared.queryLimit
        query.skip = skip
        
        return try catchParse { try query.findObjects() }
    }
    
    static func getStationsByBounds(region: MKCoordinateRegion) async throws -> [EnvironmentStation] {
        let swPoint = PFGeoPoint(latitude: region.center.latitude-(region.span.latitudeDelta/2),
                                 longitude: region.center.longitude-(region.span.longitudeDelta/2))
        let nePoint = PFGeoPoint(latitude: region.center.latitude+(region.span.latitudeDelta/2),
                                 longitude: region.center.longitude+(region.span.longitudeDelta/2))
        let poiQuery = OSCAPointOfInterest.query()!.whereKey("geopoint", withinGeoBoxFromSouthwest: swPoint, toNortheast: nePoint)
        
        let query = EnvironmentStation.query()!
            .selectKeys(["objectID","name","poi","poi.geopoint"])
            .whereKey("poi", matchesQuery: poiQuery)
        query.maxCacheAge = OSCAEnvironmentSettings.shared.maxCacheAge
        query.cachePolicy = .cacheElseNetwork
        query.limit = OSCAEnvironmentSettings.shared.queryMax // get all if possible
        
        return try catchParse { try query.findObjects() }
    }
    
    static func getStationsByBoundsAndSubCategoryId(subCategoryId: String, region: MKCoordinateRegion) async throws -> [EnvironmentStation] {
        let subCategoryQuery = EnvironmentSubCategory(withoutDataWithObjectId: subCategoryId).relation(forKey: "sensorTypes").query()
        let typeQuery = EnvironmentSensorType.query()!.whereKey("objectId", matchesQuery: subCategoryQuery)
        let sensorQuery = EnvironmentSensor.query()!.whereKey("sensorType", matchesQuery: typeQuery)
        
        let swPoint = PFGeoPoint(latitude: region.center.latitude-(region.span.latitudeDelta/2),
                                 longitude: region.center.longitude-(region.span.longitudeDelta/2))
        let nePoint = PFGeoPoint(latitude: region.center.latitude+(region.span.latitudeDelta/2),
                                 longitude: region.center.longitude+(region.span.longitudeDelta/2))
        let poiQuery = OSCAPointOfInterest.query()!.whereKey("geopoint", withinGeoBoxFromSouthwest: swPoint, toNortheast: nePoint)
        
        let query = EnvironmentStation.query()!.whereKey("objectId", matchesKey: "station", in: sensorQuery)
            .selectKeys(["objectID","name","poi","poi.geopoint"])
            .whereKey("poi", matchesQuery: poiQuery)
        query.maxCacheAge = OSCAEnvironmentSettings.shared.maxCacheAge
        query.cachePolicy = .cacheElseNetwork
        query.limit = OSCAEnvironmentSettings.shared.queryMax // get all if possible
        
        return try catchParse { try query.findObjects() }
    }
    
}
