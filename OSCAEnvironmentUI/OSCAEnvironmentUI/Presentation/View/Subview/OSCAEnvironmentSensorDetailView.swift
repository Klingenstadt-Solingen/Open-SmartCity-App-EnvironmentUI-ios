import SwiftUI
import MapKit

/**
 View showing Details of to a Sensor
 
 - Parameters:
    - backButtonKey: Text of the BackButton
    - subtitle: Text of the Subtitle
    - sensorId: objectId of the selected Sensor
 */
struct OSCAEnvironmentSensorDetailView: View {
    @EnvironmentObject var navigator: OSCAEnvironmentNavigator
    @StateObject var sensorDetailVM = OSCAEnvironmentSensorDetailViewModel()
    @StateObject var graphVM = OSCAEnvironmentGraphViewModel()
    @StateObject var sensorFavViewModel = OSCAEnvironmentSensorFavViewModel()
    var backButtonKey: String
    var subtitle: String
    var sensorId: String
    
    var body: some View {
        OSCAEnvironmentLoadingWrapper(loadingStates: sensorDetailVM.loadingState) {
            VStack(spacing: 0) {
                OSCAEnvironmentBackButton(backButtonKey: backButtonKey)
                if let sensor = sensorDetailVM.sensor {
                    OSCAEnvironmentSensorDetail(sensor: sensor).environmentObject(sensorFavViewModel)
                }
            }
        }.task() {
            await sensorDetailVM.fetchValue(sensorId: sensorId)
            
        }.refreshable {
            await sensorDetailVM.fetchValue(sensorId: sensorId)
        }
    }
}
