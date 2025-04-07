import SwiftUI
import MapKit

/**
 Creates an Annotation from a Station
 */
func createAnnotation(station: EnvironmentStation) -> MKAnnotation {
    return OSCAEnvironmentMarker(
        station.name,
        coordinate: CLLocationCoordinate2D(latitude: station.poi.geopoint.latitude, longitude: station.poi.geopoint.longitude),
        objectId: station.objectId ?? "")
}

/**
 Creates Annotations from Stations
 */
func createAnnotations(stations: [EnvironmentStation]) -> [MKAnnotation] {
    var annotations: [MKAnnotation] = []
    for station in stations {
        let marker = OSCAEnvironmentMarker(
            coordinate: CLLocationCoordinate2D(latitude: station.poi.geopoint.latitude, longitude: station.poi.geopoint.longitude),
            objectId: station.objectId ?? "")
        annotations.append(marker)
    }
    
    return annotations
}

/**
 Calculates a map region to show around a station (if available)
 */
func createRegion(station: EnvironmentStation? = nil, padding: Double = 0.01) -> MKCoordinateRegion {
    var region: MKCoordinateRegion? = nil
    
    if station != nil {
        let point = (station?.poi.geopoint)!
        region = MKCoordinateRegion(
            center:  CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude),
            span: MKCoordinateSpan(
                latitudeDelta: 0.07,
                longitudeDelta: 0.07))
    }

    return region ?? MKCoordinateRegion(center:  CLLocationCoordinate2D(latitude: 51.171517, longitude: 7.086807),
                              span: MKCoordinateSpan(latitudeDelta: 0.1,
                                                     longitudeDelta: 0.1))
}
