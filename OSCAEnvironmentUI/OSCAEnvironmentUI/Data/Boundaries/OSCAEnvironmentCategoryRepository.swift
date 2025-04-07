protocol OSCAEnvironmentCategoryRepository {
    
    static func getCategories() async throws -> [EnvironmentCategory]
}
