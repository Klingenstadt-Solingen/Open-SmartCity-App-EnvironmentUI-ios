import SwiftUI

/**
 Shows Stations on a List
 
- Parameters:
    - subCategoryId: objectId of the selected SubCategory
    - backButtonKey: Text on the BackButton
 */
struct OSCAEnvironmentStationList: View {
    @EnvironmentObject var navigator: OSCAEnvironmentNavigator
    var subCategoryId: String
    var backButtonKey: String
    @StateObject var stationListVM = OSCAEnvironmentStationListViewModel()
    
    var body: some View {
        OSCAEnvironmentLoadingWrapper(loadingStates: stationListVM.loadingState) {
            ScrollView {
                LazyVStack {
                    ForEach(0..<stationListVM.stations.endIndex, id: \.self) { index in
                        OSCAEnvironmentStationListItem(stationTitle: stationListVM.stations[index].name,
                                                       stationId: index,
                                                       buttonAction: buttonAction).task() {
                            if index == stationListVM.stations.endIndex-1 {
                                await stationListVM.fetchMoreStations(subCategoryId: subCategoryId)
                            }
                        }
                    }
                }
            }.padding(envStationListScrollViewPadding)
        }.task() {
            await stationListVM.fetchStations(subCategoryId: subCategoryId)
        }.refreshable {
            await stationListVM.fetchStations(subCategoryId: subCategoryId)
        }
    }
    
    /**
     Navigates to Sensor Grid when a Listelement is clicked
     */
    func buttonAction(stationId: Int) {
        navigator.navigate(route: .sensorGridRoute(backButtonKey: backButtonKey,
                                                   subtitle: stationListVM.stations[stationId].name,
                                                   stationId: stationListVM.stations[stationId].objectId ?? "",
                                                   subCategoryId: subCategoryId))
    }
}
