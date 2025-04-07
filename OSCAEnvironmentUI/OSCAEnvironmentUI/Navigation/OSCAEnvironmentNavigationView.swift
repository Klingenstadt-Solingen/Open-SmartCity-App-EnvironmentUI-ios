import SwiftUI

/**
 Navigation displaying a view based on the navigator route
 */
struct OSCAEnvironmentNavigationView: View {
    @EnvironmentObject var navigator: OSCAEnvironmentNavigator
    @EnvironmentObject var mainViewModel: OSCAEnvironmentMainViewModel
    
    var body: some View {
        ZStack {
            switch navigator.navRoute {
            case .subCategoryRoute(let categoryId, let cardColor):
                OSCAEnvironmentSubCategoryGridView(categoryId: categoryId, cardColor: cardColor)
            case .stationRoute(let backButtonKey, let subCategoryId, let selectedTab):
                OSCAEnvironmentStationView(backButtonKey: backButtonKey,
                                               subCategoryId: subCategoryId,
                                               selectedTab: selectedTab)
            case .sensorGridRoute(let backButtonKey, let subtitle, let stationId, let subCategoryId):
                OSCAEnvironmentSensorGridView(backButtonKey: backButtonKey,
                                              subtitle: subtitle,
                                              stationId: stationId,
                                              subCategoryId: subCategoryId)
            case .sensorDetailRoute(let backButtonKey, let subtitle, let sensorId):
                OSCAEnvironmentSensorDetailView(backButtonKey: backButtonKey,
                                                subtitle: subtitle,
                                                sensorId: sensorId)
            case .fullscreenMapRoute:
                OSCAEnvironmentFullscreenMapView()
            case .emptyRoute:
                ProgressView()
            }
        }
    }
}
