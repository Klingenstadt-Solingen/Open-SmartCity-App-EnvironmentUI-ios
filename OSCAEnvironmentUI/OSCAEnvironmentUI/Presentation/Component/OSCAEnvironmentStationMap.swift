import SwiftUI
import MapKit

/**
 Shows Stations on a Map
 
- Parameters:
    - subCategoryId: objectId of the selected SubCategory
    - backButtonKey: Text on the BackButton
 */
struct OSCAEnvironmentStationMap: View {
    @EnvironmentObject var navigator: OSCAEnvironmentNavigator
    var subCategoryId: String
    var backButtonKey: String
    @StateObject var stationMapVM = OSCAEnvironmentStationMapViewModel()
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.16553398473733, longitude: 7.065702202877448),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    var body: some View {
        OSCAEnvironmentMapView(
            annotationItems: stationMapVM.stations,
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
        }.task {
            await stationMapVM.fetchStations(subCategoryId: subCategoryId, region: region)
        }
        .clipShape(envRoundedShape)
        .shadow(radius: 2)
        .padding(envStationListMapPadding)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    /**
     Navigates to Sensor Grid when a map marker is clicked
     */
    func navigateAction(station: EnvironmentStation) {
        navigator.navigate(route: .sensorGridRoute(backButtonKey: backButtonKey,
                                                   subtitle: station.name,
                                                   stationId: station.objectId ?? "",
                                                   subCategoryId: subCategoryId))
    }
    
    func regionChanged(_ region: MKCoordinateRegion) {
        Task {
            await stationMapVM.fetchStations(subCategoryId: subCategoryId, region: region)
        }
    }
}
