import Foundation
import MapKit

class OSCAEnvironmentTileOverlay: MKTileOverlay {
    let MAP_SIZE = 20037508.34789244 * 2
    let ORIG_X = -20037508.34789244
    let ORIG_Y = 20037508.34789244
    
    override func url(forTilePath path: MKTileOverlayPath) -> URL {
        let x = Double(path.x)
        let y = Double(path.y)
        
        let tileSize = MAP_SIZE / pow(2, Double(path.z));
        let minx = ORIG_X + x * tileSize;
        let maxx = ORIG_X + (x + 1) * tileSize;
        let miny = ORIG_Y - (y + 1) * tileSize;
        let maxy = ORIG_Y - y * tileSize;
        
        return URL(
            string: "https://geodaten.metropoleruhr.de/spw2?SERVICE=WMS&VERSION=1.3.0&REQUEST=GetMap&FORMAT=image%2Fpng&LAYERS=spw2_light_grundriss&STYLES=&CRS=EPSG:3857&WIDTH=256&HEIGHT=256&BBOX=\(minx),\(miny),\(maxx),\(maxy)"
        )!
    }
}
