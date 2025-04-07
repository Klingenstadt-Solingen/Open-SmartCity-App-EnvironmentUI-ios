import MapKit

protocol OSCAEnvironmentStationRepository {
    
    static func getStationById(stationId: String) async throws -> EnvironmentStation?
    static func getStationsBySubCategoryId(subCategoryId: String, skip: Int) async throws -> [EnvironmentStation]
    static func getStationsByBounds(region: MKCoordinateRegion) async throws -> [EnvironmentStation]
    static func getStationsByBoundsAndSubCategoryId(subCategoryId: String, region: MKCoordinateRegion) async throws -> [EnvironmentStation]
}
