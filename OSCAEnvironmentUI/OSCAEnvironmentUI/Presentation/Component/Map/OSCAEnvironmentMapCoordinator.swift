import SwiftUI
import MapKit

class OSCAEnvironmentMapCoordinator<T: Equatable, Content: View>: NSObject, MKMapViewDelegate {
    var annotationItems: [T] = []
    var annotations: [OSCAEnvironmentMapAnnotation<T, Content>] = []
    var regionChanged: (MKCoordinateRegion) -> ()
    
    init(regionChanged: @escaping (MKCoordinateRegion) -> Void) {
        self.regionChanged = regionChanged
    }
        
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let annotation = annotation as? OSCAEnvironmentMapAnnotation<T, Content> {
            let identifier = annotation.content.identifier
            
            if let annotation = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                return annotation
            }
            
            return OSCAEnvironmentMapAnnotationView<T, Content> (
                mapAnnotation: annotation,
                reuseIdentifier: identifier
            )
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyOverlay = overlay as? MKPolygon {
            let polyRender = MKPolygonRenderer(polygon: polyOverlay)
            polyRender.strokeColor = UIColor(Color.primary)
            polyRender.lineWidth = 4
            polyRender.alpha = 0.8
            return polyRender
        } else if let tileOverlay = overlay as? MKTileOverlay {
           return  MKTileOverlayRenderer(overlay: tileOverlay)
        }
        return MKPolygonRenderer()
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        regionChanged(mapView.region)
    }
}
