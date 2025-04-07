import SwiftUI
import MapKit

/**
 Map View showing Annotations
 
 - Parameters:
    - region: Shown region on the map
    - regionChanged: Function called when the shown region changes
    - annotationAction: Function called  when an Annotation is clicked
    - singularStation: If passed, locks the Map from beign moved or zoomed
 */

struct OSCAEnvironmentMapView<T: Equatable, Content: View>: UIViewRepresentable {
    var annotationItems: [T] = []
    var region: MKCoordinateRegion?
    var regionChanged: (MKCoordinateRegion) -> () = { _ in }
    
    @ViewBuilder var content: (T) -> OSCAEnvironmentMapMarkerView<Content>
    
    func makeCoordinator() -> OSCAEnvironmentMapCoordinator<T, Content> {
        OSCAEnvironmentMapCoordinator(regionChanged: regionChanged)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let view = MKMapView(frame: .zero)
        view.delegate = context.coordinator
        if let region = region {
            view.region = region
        }
        view.mapType = .mutedStandard
        view.pointOfInterestFilter = .excludingAll
        view.cameraZoomRange = MKMapView.CameraZoomRange(minCenterCoordinateDistance: 1000)
        
        let underlay = OSCAEnvironmentTileOverlay()
        underlay.canReplaceMapContent = true
        view.addOverlay(underlay)
        
        view.isScrollEnabled = true
        view.isZoomEnabled = true
        view.isPitchEnabled = true
        view.isRotateEnabled = true
        view.showsUserLocation = true
        view.isExclusiveTouch = false
        return view
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        if annotationItems != context.coordinator.annotationItems {
            let annotations = annotationItems.map { annotationItem in
                return OSCAEnvironmentMapAnnotation(content: content, annotationItem: annotationItem)
            }
            view.removeAnnotations(context.coordinator.annotations)
            view.addAnnotations(annotations)
            context.coordinator.annotationItems = annotationItems
            context.coordinator.annotations = annotations
        }
    }
    
    func zoom(_ mapView: MKMapView, for overlay: MKOverlay) {
        let zoomSpace: CGFloat = 50
        mapView.setVisibleMapRect(
            overlay.boundingMapRect,
            edgePadding: UIEdgeInsets(top: zoomSpace, left: zoomSpace, bottom: zoomSpace, right: zoomSpace),
            animated: true
        )
    }
}


struct EmptyAnnotationValue: Equatable {}

extension OSCAEnvironmentMapView where Content == EmptyView, T == EmptyAnnotationValue {
    init(
        region: MKCoordinateRegion? = nil
    ) {
        self.region = region
        self.content = { _ in OSCAEnvironmentMapMarkerView()}
    }
}
