import Foundation
import MapKit
import SwiftUI

final class OSCAEnvironmentMapAnnotation<T, Content: View>: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var annotationItem: T
    var content: OSCAEnvironmentMapMarkerView<Content>
    
    init(@ViewBuilder content: @escaping (T) -> OSCAEnvironmentMapMarkerView<Content>, annotationItem: T) {
        self.content = content(annotationItem)
        self.coordinate = self.content.coordinate
        self.title = self.content.title
        self.annotationItem = annotationItem
    }
}
