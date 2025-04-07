import ParseCore

/**
 Repository for fetching locales
 */
struct OSCAEnvironmentLanguageRepositoryImpl: OSCAEnvironmentLanguageRepository {
    
    static func getAlternativeLanguage(prefix: String) async -> String? {
        let query = EnvironmentLanguage.query()!.whereKey("locale", hasPrefix: prefix).order(byAscending: "priority")
        var language: String? = nil
        do {
            var fetchedLanguage: EnvironmentLanguage = try catchParse { try query.getFirstObject() }
            language = fetchedLanguage.locale
        } catch {}
        
        return language
    }
    
    static func checkLanguage(language: String) async -> Bool {
        let query = EnvironmentLanguage.query()!.whereKey("locale", equalTo: language)
        query.maxCacheAge = OSCAEnvironmentSettings.shared.maxLocaleCacheAge
        query.cachePolicy = .cacheElseNetwork
        var languageExists = false
        do {
            try query.getFirstObject()
            languageExists = true
        }   catch {}
        
        return languageExists
    }
}
