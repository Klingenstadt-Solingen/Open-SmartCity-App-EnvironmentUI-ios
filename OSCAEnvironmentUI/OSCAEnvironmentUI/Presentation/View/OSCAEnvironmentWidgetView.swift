import SwiftUI

struct OSCAEnvironmentWidgetView: View {
    @StateObject var localeViewModel = OSCAEnvironmentLocaleViewModel()
    @StateObject var sensorFavViewModel = OSCAEnvironmentSensorFavViewModel()
    @State var isEditing = false
    @FocusState var isFocused
    @State var selectedSensor: EnvironmentSensor?
    
    var body: some View {
        OSCAEnvironmentLoadingWrapper(loadingStates: sensorFavViewModel.loadingState, localeViewModel.loadingState) {
            ScrollView(.horizontal) {
                LazyHGrid(rows: .init(repeating: GridItem( .fixed(110)), count: 2), alignment: .center) {
                    ForEach(sensorFavViewModel.favSensors, id: \.self) { sensor in
                        ZStack(alignment: .topTrailing) {
                            VStack(alignment: .leading, spacing: 0) {
                                HStack(alignment: .top, spacing: 0) {
                                    OSCAEnvironmentWebImage(
                                        url: sensor.sensorType.icon.icon.url,
                                        color: envSensorGridIconColor,
                                        width: envSensorGridIconSize,
                                        height: envSensorGridIconSize
                                    )
                                    Spacer()
                                    Text(sensor.sensorType.unit).font(.system(size: 14).bold())
                                        .foregroundColor(envSensorGridUnitTitleColor)
                                        .frame(alignment: .topTrailing)
                                }.frame(alignment: .top)
                                Spacer()
                                Text(sensor.value, format: .number.rounded(increment: 0.01)).font(.system(size: 22).bold())
                                    .foregroundColor(envSensorGridValueTitleColor)
                                    .frame(alignment: .bottom)
                                Text(verbatim:  sensor.station.name)
                                    .lineLimit(1)
                                    .font(.system(size: 8).bold())
                                    .foregroundColor(envSensorGridSensorTitleColor)
                                    .frame(alignment: .bottom)
                                LocaleText(key: sensor.sensorType.name)
                                    .lineLimit(1)
                                    .font(.system(size: 8).bold())
                                    .foregroundColor(envSensorGridSensorTitleColor)
                                    .frame(alignment: .bottom)
                            }
                            .aspectRatio(1, contentMode: .fit)
                            .padding(10)
                            .background(
                                RoundedRectangle(
                                    cornerRadius: envGridButtonCornerRadius
                                )
                                .foregroundColor(Color.white)
                                .shadow(radius: 2)
                                .shadow(radius: 2)
                            )
                            .onTapGesture {
                                if isEditing {
                                    withAnimation(.snappy) {
                                        isEditing = false
                                    }
                                } else {
                                    selectedSensor = sensor
                                }
                            }
                            .onLongPressGesture(minimumDuration: 1) {
                                withAnimation {
                                    isEditing = true
                                }
                            }
                            if isEditing {
                                Button {
                                    withAnimation(.snappy) {
                                        sensorFavViewModel.toggleFavSensor(objectId: sensor.objectId!)
                                    }
                                } label: {
                                    Image(systemName: "xmark.square.fill")
                                        .font(.title)
                                        .symbolRenderingMode(.palette)
                                        .foregroundStyle(.white, Color.red)
                                }
                                .offset(x: 8, y: -8)
                            }
                        }
                    }.frame(maxWidth: .infinity)
                }.padding(10)
            }.frame(maxWidth: .infinity).padding(-10)
        }.sheet(item: $selectedSensor) { sensor in
            if #available(iOS 16.0, *) {
                OSCAEnvironmentSensorDetailSheet(sensor: sensor).presentationDragIndicator(.visible)
                    .environmentObject(sensorFavViewModel)
                    .environmentObject(localeViewModel)
            } else {
                OSCAEnvironmentSensorDetailSheet(sensor: sensor)
                    .environmentObject(sensorFavViewModel)
                    .environmentObject(localeViewModel)
            }
        }
        .task {
            await sensorFavViewModel.getFavSensors()
        }
        .task(id: "\(Locale.preferredLanguages.first ?? "de-DE")") {
            await localeViewModel.fetchLocales()
        }
        .frame(height: 220)
        .environmentObject(localeViewModel)
        .onTapGesture {
            if isEditing {
                withAnimation(.snappy) {
                    isEditing = false
                }
            }
        }
    }
}
