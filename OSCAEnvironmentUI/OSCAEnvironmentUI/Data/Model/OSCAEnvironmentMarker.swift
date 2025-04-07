import MapKit

/**
 Annotation to display on a Map
 */
class OSCAEnvironmentMarker: NSObject, MKAnnotation{
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var objectId: String
    init(_ name: String? = nil, coordinate: CLLocationCoordinate2D, objectId: String){
        title = name
        self.coordinate = coordinate
        self.objectId = objectId
    }
}
