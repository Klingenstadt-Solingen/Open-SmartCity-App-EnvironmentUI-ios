import SwiftUI

/**
 Shape of a Category Tab
 
 - Parameters:
    - corner: Corner Radius of the top edges
 */
struct OSCAEnvironmentCategoryTabShape: Shape {
    var corner: CGFloat = envCategoryTabShapeCorner
    
    func path(in rect: CGRect) -> Path {
        var tabPath = Path()
        
        tabPath.move(to: CGPoint(x: rect.maxX, y: rect.maxY)) // moves to the bottom right corner
        tabPath.addLine(to: CGPoint(x: rect.maxX, y: rect.minY+corner)) // draws a line top the top right corner
        // draws a curve around the corner
        tabPath.addArc(center: CGPoint(x: rect.maxX-corner, y: rect.minY+corner),
                       radius: corner,
                       startAngle: Angle(degrees: 0),
                       endAngle: Angle(degrees: 270),
                       clockwise: true)
        tabPath.addLine(to: CGPoint(x: rect.minX+corner, y: rect.minY)) // draws a line to the top left corner
        // draws a curve a around the corner
        tabPath.addArc(center: CGPoint(x: rect.minX+corner, y: rect.minY+corner),
                       radius: corner, startAngle: Angle(degrees: 270),
                       endAngle: Angle(degrees: 180),
                       clockwise: true)
        tabPath.addLine(to: CGPoint(x: rect.minX, y: rect.maxY)) // draws a line ot the bottom left corner
        
        return tabPath
    }
}
