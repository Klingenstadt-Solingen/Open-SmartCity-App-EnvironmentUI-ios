import SwiftUI

/**
 Shape of the Graph Axes

 - Parameters:
    - dataCount: Count of datapoints which will be shown
 */
struct OSCAEnvironmentCartesianShape: Shape {
    var dataCount: Int

    func path(in rect: CGRect) -> Path {
        var graphPath = Path()
        let widthStep = rect.size.width / CGFloat(dataCount - 1) // calculates step distance on x-axis by dividing available space by dataCount
        let heightStep = rect.size.height/10 // calculates step distance on y-axis

        graphPath.move(to: CGPoint(x: rect.minX, y: rect.minY)) // moves to top left corner

        for index in 1..<11 {
            let vmove = CGFloat(index) * heightStep - heightStep / 2 // calculates y-axis offset of the step
            let vline = CGFloat(3) // marker line width
            graphPath.addLine(to: CGPoint(x: rect.minX, y: rect.minY + vmove)) // draws a line to the next step
            graphPath.addLine(to: CGPoint(x: rect.minX + vline, y: rect.minY + vmove)) // draws a line to the right of the step
            graphPath.addLine(to: CGPoint(x: rect.minX - vline, y: rect.minY + vmove)) // draws a line to the left of the step
            graphPath.move(to: CGPoint(x: rect.minX, y: rect.minY + vmove)) // moves back to the step
        }
        graphPath.addLine(to: CGPoint(x: rect.minX, y: rect.maxY)) // draws a line to the bottom left corner

        for index in 1..<dataCount - 1 {
            let hmove = CGFloat(index) * widthStep // calculates x-axis offset of the step
            let hline = CGFloat(3) // marker line height
            graphPath.addLine(to: CGPoint(x: rect.minX + hmove, y: rect.maxY)) // draws a line to the next step
            graphPath.addLine(to: CGPoint(x: rect.minX + hmove, y: rect.maxY + hline)) // draws a line to the bottom of the step
            graphPath.addLine(to: CGPoint(x: rect.minX + hmove, y: rect.maxY - hline)) // draws a line to the top of the step
            graphPath.move(to: CGPoint(x: rect.minX + hmove, y: rect.maxY)) // moves back to the step
        }
        graphPath.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // draws line to the bottom right corner

        return graphPath
    }
}

/**
 Shape of the graph line based on given data and precalculated dataStep

 - Parameters:
    - data: Points to be drawn in a line
    - dataStep: Step on the y-axis (one marker line)
*/
struct OSCAEnvironmentGraphShape: Shape {
    var data: [EnvironmentSensorValue]
    var dataStep: CGFloat

    func path(in rect: CGRect) -> Path {
        getDataPath(rect: rect, data: data, dataStep: dataStep)
    }
}

/**
 Shape of the closed graph line based on given data and precalculated dataStep

 - Parameters:
    - data: Points to be drawn in a line
    - dataStep: Step on the y-axis (one marker line)
 */
struct OSCAEnvironmentGraphGradientShape: Shape {
    var data: [EnvironmentSensorValue]
    var dataStep: CGFloat

    func path(in rect: CGRect) -> Path {
        var gradientPath = getDataPath(rect: rect, data: data, dataStep: dataStep)
        gradientPath.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // draws a line to the bottom right
        gradientPath.addLine(to: CGPoint(x: rect.minX, y: rect.maxY)) // draws a line to the bottom left
        gradientPath.closeSubpath()

        return gradientPath
    }
}
