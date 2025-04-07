protocol OSCAEnvironmentSubCategoryRepository {
    
    static func getSubCategoryById(subCategoryId: String) async throws -> EnvironmentSubCategory?
    static func getSubCategoriesByCategoryId(categoryId: String, skip: Int) async throws -> [EnvironmentSubCategory]
}
