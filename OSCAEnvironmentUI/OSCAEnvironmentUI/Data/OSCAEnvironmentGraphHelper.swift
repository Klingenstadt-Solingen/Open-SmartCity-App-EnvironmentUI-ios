import SwiftUI

/**
 Calculates data step based on the highest coordinate
 */
func getDataStep(data: [EnvironmentSensorValue]) -> CGFloat {
    var highestCoord: Double = 0
    for index in 0..<data.count {
        if highestCoord < data[index].value {
            highestCoord = data[index].value

        }
    }

    return highestCoord / 10
}

/**
 Creates a path based on data points and data step within a rectangle
 */
func getDataPath(rect: CGRect, data: [EnvironmentSensorValue], dataStep: CGFloat) -> Path {
    var dataPath = Path()
    let dataCount = CGFloat(data.count)
    let hstep = rect.size.width/(dataCount - 1)
    let vstep = rect.size.height / 10

    dataPath.move(to: CGPoint(x: rect.minX,
                              y: rect.size.height + vstep / 2 - vstep * (data[0].value / dataStep)))

    for index in 1..<Int(dataCount) {
        dataPath.addLine(to: CGPoint(
            x: hstep * CGFloat(index),
            y: rect.size.height + vstep / 2 - vstep * (data[index].value / dataStep)))
    }

    return dataPath
}
