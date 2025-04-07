import SwiftUI

/**
 Grid View showing Sensors related to a Sensor Station
 
 - Parameters:
    - backButtonKey: Text on the BackButton
    - subtitle: Text below the BackButton
    - stationId: objectId of the selected Station
    - subCategoryId: objectId of the selected SubCategory
 */
struct OSCAEnvironmentSensorGridView: View {
    @EnvironmentObject var navigator: OSCAEnvironmentNavigator
    @StateObject var sensorVM = OSCAEnvironmentSensorViewModel()
    var backButtonKey: String
    var subtitle: String
    var stationId: String
    var subCategoryId: String?
    
    var body: some View {
        OSCAEnvironmentLoadingWrapper(loadingStates: sensorVM.loadingState) {
            VStack(spacing: 0) {
                if subCategoryId == nil {
                    OSCAEnvironmentBackButton(backButtonString: subtitle)
                    OSCAEnvironmentSubtitle(subtitleKey: "select_sensor")
                } else {
                    OSCAEnvironmentBackButton(backButtonKey: backButtonKey)
                    OSCAEnvironmentSubtitle(subtitleString: subtitle)
                }
                OSCAEnvironmentGrid(
                    itemCount: sensorVM.sensors.endIndex,
                    createGridItem: createGridItem,
                    fetchMore: { await sensorVM.fetchMoreSensors(stationId: stationId, subCategoryId: subCategoryId) } )
            }
        }.task {
            await sensorVM.fetchSensors(stationId: stationId, subCategoryId: subCategoryId)
        }.refreshable {
            await sensorVM.fetchSensors(stationId: stationId, subCategoryId: subCategoryId)
        }
    }
    
    @ViewBuilder func createGridItem(itemId: Int) -> AnyView {
        AnyView(OSCAEnvironmentSensorGridItem(sensor: sensorVM.sensors[itemId], itemId: itemId, buttonAction: buttonAction))
    }
    
    func buttonAction(sensorId: Int){
        navigator.navigate(
            route: .sensorDetailRoute(
                backButtonKey: sensorVM.sensors[sensorId].sensorType.name,
                subtitle: subtitle,
                sensorId: sensorVM.sensors[sensorId].objectId ?? ""
            )
        )
    }
}
