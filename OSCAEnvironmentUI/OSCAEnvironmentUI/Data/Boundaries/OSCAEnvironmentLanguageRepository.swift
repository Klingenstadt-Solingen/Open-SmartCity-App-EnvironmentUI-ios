protocol OSCAEnvironmentLanguageRepository {
    
    static func getAlternativeLanguage(prefix: String) async -> String?
    static func checkLanguage(language: String) async -> Bool
}
