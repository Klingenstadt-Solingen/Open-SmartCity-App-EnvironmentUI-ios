import ParseCore

/**
 Repository for fetching  subcategories
 */
struct OSCAEnvironmentSubCategoryRepositoryImpl: OSCAEnvironmentSubCategoryRepository {
    
    static func getSubCategoryById(subCategoryId: String) async throws -> EnvironmentSubCategory? {
        let query = EnvironmentSubCategory.query()!
        query.maxCacheAge = OSCAEnvironmentSettings.shared.maxCacheAge
        query.cachePolicy = .cacheElseNetwork
        
        return try catchParse { try query.getObjectWithId(subCategoryId) }
    }
    
    static func getSubCategoriesByCategoryId(categoryId: String, skip: Int) async throws -> [EnvironmentSubCategory] {
        let categoryQuery = EnvironmentCategory(withoutDataWithObjectId: categoryId).relation(forKey: "subCategories").query()
        let query = EnvironmentSubCategory.query()!.whereKey("objectId", matchesQuery: categoryQuery).order(byAscending: "order")
            .includeKey("icon")
            .includeKey("category")
        query.maxCacheAge = OSCAEnvironmentSettings.shared.maxCacheAge
        query.cachePolicy = .cacheElseNetwork
        query.limit = OSCAEnvironmentSettings.shared.queryLimit
        query.skip = skip
        
        return try catchParse { try query.findObjects() }
    }
}
