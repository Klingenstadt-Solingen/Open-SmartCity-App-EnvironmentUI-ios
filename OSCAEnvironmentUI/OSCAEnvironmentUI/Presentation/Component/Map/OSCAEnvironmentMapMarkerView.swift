import SwiftUI
import MapKit

struct OSCAEnvironmentMapMarkerView<Content>: View where Content: View {
    var title: String?
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    var identifier: String = ""
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        content()
    }
}

extension OSCAEnvironmentMapMarkerView where Content == EmptyView {
    init() {
        self.init {
            EmptyView()
        }
    }
}
