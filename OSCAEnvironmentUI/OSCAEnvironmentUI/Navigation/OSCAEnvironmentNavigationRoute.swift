import SwiftUI

/**
 Route for Navigation with additional variables
 */
enum EnvNavigationRoute: Equatable {
    case emptyRoute
    case fullscreenMapRoute
    case subCategoryRoute(categoryId: String, cardColor: Color)
    case stationRoute(backButtonKey: String, subCategoryId: String, selectedTab: Int)
    case sensorGridRoute(backButtonKey: String, subtitle: String, stationId: String, subCategoryId: String?)
    case sensorDetailRoute(backButtonKey: String, subtitle: String, sensorId: String)
}
