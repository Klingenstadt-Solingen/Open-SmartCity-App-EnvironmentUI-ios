import Foundation
import SwiftUI

/**
 Responsible for fetching Locales
 */
class OSCAEnvironmentLocaleViewModel: OSCAEnvironmentLoadable {
    let langDefault = "en-EN"
    @Published var locales: [EnvironmentLocale] = []
    @Published var language: String = Locale.preferredLanguages.first ?? "en"
    
    func fetchLocales() async {
        await errorToLoadingState {
            let checkLanguage = await OSCAEnvironmentLanguageRepositoryImpl.checkLanguage(language: language)
            let fetchLanguage = !checkLanguage ? await OSCAEnvironmentLanguageRepositoryImpl.getAlternativeLanguage(prefix: Locale.preferredLanguages.first?.components(separatedBy: "-").first ?? "en") ?? langDefault : language
            let queryResult = try await OSCAEnvironmentLocaleRepositoryImpl.getLocalesByLanguage(language: fetchLanguage, cachePolicy: .cacheElseNetwork)
            await MainActor.run {
                language = fetchLanguage
                locales = queryResult
            }
        }
    }
    
    /** Checks if key is in locales*/
    func isInLocales(key: String) -> Bool {
        for locale in locales {
            if locale.key == key && locale.locale == language {
                return true
            }
        }
        return false
    }
    
    /**
     Checks if key is already in locales and fetches it if needed
     */
    
    func getLocaleForKey(_ key: String, string: Binding<String>) async {
        
            let localeForKey: EnvironmentLocale? = locales.first { locale in
                locale.key == key && locale.locale == language
            }
            if let locale = localeForKey {
                string.wrappedValue = locale.value
                return
            } else {
                string.wrappedValue = key
            }
        do {
            if let locale = try await OSCAEnvironmentLocaleRepositoryImpl.getLocaleByLanguageAndKey(language: language, key: key) {
                string.wrappedValue = locale.value
                guard isInLocales(key: key) else {
                    await MainActor.run {
                        locales.append(locale)
                    }
                    return
                }
            }
        } catch {}
    }
}
