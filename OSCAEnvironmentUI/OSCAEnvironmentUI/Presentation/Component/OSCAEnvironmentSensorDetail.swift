import SwiftUI
import MapKit

struct OSCAEnvironmentSensorDetail: View {
    @EnvironmentObject var sensorFavViewModel: OSCAEnvironmentSensorFavViewModel
    @StateObject var graphVM = OSCAEnvironmentGraphViewModel()
    var sensor: EnvironmentSensor
    var subtitlePadding: Bool = true
    
    var body: some View {
        VStack(spacing: 0) {
            OSCAEnvironmentSubtitle(subtitleString: sensor.station.name, padding: subtitlePadding)
            Spacer().frame(height: 25)
            ScrollView {
                LazyVStack(spacing: 15) {
                    HStack(alignment: .bottom, spacing: 15) {
                        OSCAEnvironmentWebImage(
                            url: sensor.sensorType.icon.icon.url,
                            color: envSensorDetailIconColor,
                            width: envSensorDetailIconSize,
                            height: envSensorDetailIconSize
                        )
                        OSCAEnvironmentSensorValue(sensor: sensor)
                        
                        Spacer()
                        Button(action: {
                            sensorFavViewModel.toggleFavSensor(objectId: sensor.objectId ?? "", sensor: sensor)
                        }) {
                            let favIcon = Image(sensorFavViewModel.isFavSensor(objectId: sensor.objectId ?? "") ? "ic_fav_enabled" : "ic_fav_disabled", bundle: OSCAEnvironmentUI.bundle)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: envSensorDetailIconSize, maxHeight: envSensorDetailIconSize)
                            if #available(iOS 17.0, *) {
                                favIcon.symbolEffect(.bounce, value: sensorFavViewModel.isFavSensor(objectId: sensor.objectId ?? ""))
                            } else {
                                favIcon
                            }
                        }
                    }
                    OSCAEnvironmentLoadingWrapper(
                        loadingStates: graphVM.loadingState,
                        height: 350
                    ) {
                        OSCAEnvironmentGraph(
                            data: graphVM.graphData.reversed(),
                            sensor: sensor
                        )
                    }
                    .background(envRoundedShape.foregroundColor(envGraphBackgroundColor).shadow(radius: 3))
                    .padding(envGraphExternalPadding)
                    .task {
                        await graphVM.fetchGraphData(refId: sensor.refId)
                    }
                    Spacer().frame(height: 2)
                    LocaleText(key: sensor.sensorType.definition).font(.system(size: envSensorDetailDescriptionFontSize))
                    Spacer().frame(height: 2)
                    HStack {
                        Text("sensor_location", bundle: OSCAEnvironmentUI.bundle)
                            .font(.system(size: envSensorDetailMapTitleSize).bold()).foregroundColor(envSensorDetailMapTitleColor)
                        Spacer()
                    }
                    OSCAEnvironmentMapView(
                        annotationItems: [sensor.station],
                        region: createRegion(station: sensor.station)
                    ) { station in
                        OSCAEnvironmentMapMarkerView(
                            title: station.name,
                            coordinate: CLLocationCoordinate2D(
                                latitude: station.poi.geopoint.latitude,
                                longitude: station.poi.geopoint.longitude
                            ),
                            identifier: station.objectId ?? ""
                        ) {
                            OSCAEnvironmentMapMarker(station: station)
                        }
                    }
                    .aspectRatio(1, contentMode: .fit)
                    .clipShape(envRoundedShape)
                    .shadow(radius: 3)
                }.padding(envScrollViewPadding) // enable shadows escaping scroll view horizontally
            }.padding(envScrollViewPaddingCancel) // by adding negative main padding and adding it back in the subview
        }
    }
}
