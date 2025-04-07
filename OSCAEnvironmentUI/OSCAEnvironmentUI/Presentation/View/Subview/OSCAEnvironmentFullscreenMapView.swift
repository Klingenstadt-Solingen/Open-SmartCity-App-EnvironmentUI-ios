import SwiftUI
import MapKit

struct OSCAEnvironmentFullscreenMapView: View {
    @EnvironmentObject var navigator: OSCAEnvironmentNavigator
    @StateObject var mainMapVM = OSCAEnvironmentFullscreenMapViewModel()
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.16553398473733, longitude: 7.065702202877448),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    var body: some View {
        ZStack() {
            OSCAEnvironmentMapView(
                annotationItems: mainMapVM.stations,
                region: region,
                regionChanged: regionChanged
            ) { station in
                OSCAEnvironmentMapMarkerView(
                    title: station.name,
                    coordinate: CLLocationCoordinate2D(
                        latitude: station.poi.geopoint.latitude,
                        longitude: station.poi.geopoint.longitude
                    ),
                    identifier: station.objectId ?? ""
                ) {
                    OSCAEnvironmentMapMarker(station: station, navigateAction: navigateAction)
                }
            }
            .clipShape(envRoundedShape)
                .shadow(radius: 2)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack() {
                Spacer()
                HStack() {
                    Spacer()
                    Button(action: { navigator.navigateBack() }) {
                        Image("ic_map_with_marker", bundle: OSCAEnvironmentUI.bundle)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color("EnvTextTitleColor", bundle: OSCAEnvironmentUI.bundle))
                            .frame(maxWidth: 35, maxHeight: 35)
                            .padding(10)
                    }
                    .background(RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("EnvCategoryTabSelectedColor", bundle: OSCAEnvironmentUI.bundle)))
                }
            }
        }.task {
            await mainMapVM.fetchStations(region)
        }
    }
    
    /**
     Navigates to Sensor Grid when a map marker is clicked
     */
    func navigateAction(station: EnvironmentStation) {
        navigator.navigate(route: .sensorGridRoute(backButtonKey: "select_sensor",
                                                   subtitle: station.name,
                                                   stationId: station.objectId ?? "",
                                                   subCategoryId: nil))
    }
    
    func regionChanged(_ region: MKCoordinateRegion) {
        Task {
            await mainMapVM.fetchStations(region)
        }
    }
}





