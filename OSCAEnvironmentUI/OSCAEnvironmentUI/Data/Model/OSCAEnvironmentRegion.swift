import MapKit

/**
 Adds comparison functionality around a MKCoordinateRegion
 */
class OSCAEnvironmentRegion: Equatable {
    var mkRegion: MKCoordinateRegion
    
    init(_ mkRegion: MKCoordinateRegion) {
        self.mkRegion = mkRegion
    }
    
    func updateRegion(_ region: MKCoordinateRegion) {
        mkRegion = region
    }
    
    static func ==(lhs: OSCAEnvironmentRegion, rhs: OSCAEnvironmentRegion) -> Bool {
        let longCenter = lhs.mkRegion.center.longitude == rhs.mkRegion.center.longitude
        let latCenter = lhs.mkRegion.center.longitude == rhs.mkRegion.center.longitude
        let longSpan = lhs.mkRegion.span.longitudeDelta == rhs.mkRegion.span.longitudeDelta
        let latSpan = lhs.mkRegion.span.latitudeDelta == rhs.mkRegion.span.latitudeDelta
        
        return longCenter && latCenter && longSpan && latSpan
    }
}
