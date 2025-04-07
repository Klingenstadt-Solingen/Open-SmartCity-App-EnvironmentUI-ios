import ParseCore

protocol OSCAEnvironmentLocaleRepository {
    
    static func getLocaleByLanguageAndKey(language: String, key: String) async throws -> EnvironmentLocale?
    static func getLocalesByLanguage(language: String, cachePolicy: PFCachePolicy) async throws -> [EnvironmentLocale]
}
