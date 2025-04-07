import SwiftUI

/**
 List View showing Sensor Stations related to a SubCategory
 
 - Parameters:
    - backButtonKey: Text on the BackButton
    - subCategoryId: objectId of the selected SubCategory
    - selectedTab: determines which Tab is selected
 */
struct OSCAEnvironmentStationView: View {
    @EnvironmentObject var navigator: OSCAEnvironmentNavigator
    var backButtonKey: String
    var subCategoryId: String
    var selectedTab: Int
    
    var body: some View {
        VStack(spacing: 0) {
            OSCAEnvironmentBackButton(backButtonKey: backButtonKey)
            OSCAEnvironmentSubtitle(subtitleKey: "choose_station")
            OSCAEnvironmentStationListTabs(selectedTab: selectedTab, changeTab: changeTab)
            switch selectedTab {
            case 1:
                OSCAEnvironmentStationMap(subCategoryId: subCategoryId, backButtonKey: backButtonKey)
            default:
                OSCAEnvironmentStationList(subCategoryId: subCategoryId, backButtonKey: backButtonKey)
            }
        }
    }
    
    func changeTab(tab: Int) {
        if !(selectedTab == tab) {
            navigator.navigate(route: .stationRoute(backButtonKey: backButtonKey, subCategoryId: subCategoryId, selectedTab: tab), replace: true)
        }
    }
}
