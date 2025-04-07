import ParseCore

/**
 Repository for fetching  categories
 */
struct OSCAEnvironmentCategoryRepositoryImpl: OSCAEnvironmentCategoryRepository {
    
    static func getCategories() async throws -> [EnvironmentCategory] {
        let query = EnvironmentCategory.query()!.order(byAscending: "order")
        query.maxCacheAge = OSCAEnvironmentSettings.shared.maxCacheAge
        query.cachePolicy = .cacheElseNetwork
        query.limit = OSCAEnvironmentSettings.shared.queryMax // get all categories if possible
        
        return try catchParse{ try query.findObjects() }
    }
}
