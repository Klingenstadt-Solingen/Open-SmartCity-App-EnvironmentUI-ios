import SwiftUI

struct OSCAEnvironmentMapMarker: View {
    var station: EnvironmentStation
    var navigateAction: (EnvironmentStation) -> () = { _ in }
    @State var popover = false
    
    var body: some View {
        Button(action: {} ) {
            Image("default_map_marker", bundle: OSCAEnvironmentUI.bundle)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 30, maxHeight: 40)
                .highPriorityGesture(
                    LongPressGesture()
                        .onEnded { _ in
                            popover = true
                        }
                )
                .simultaneousGesture(
                    TapGesture()
                        .onEnded { _ in
                            popover = false
                            navigateAction(station)
                        }
                )
        }.popover(isPresented: $popover) {
            if #available(iOS 16.4, *) {
                OSCAEnvironmentMarkerSheet(name: station.name)
                    .presentationCompactAdaptation(.popover)
            } else {
                OSCAEnvironmentMarkerSheet(name: station.name)
            }
        }
    }
}


