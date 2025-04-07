import SwiftUI
import Charts

/**
 Graph View showing a line of data points
 
 - Parameters:
 - data: Array of the SensorValues
 - availableWidth: Width of the graph
 - height: Height of the graph
 - drawText: Enables showing text on the left and bottom of the graph
 */
struct OSCAEnvironmentGraph: View {
    @EnvironmentObject var localeViewModel: OSCAEnvironmentLocaleViewModel
    var data: [EnvironmentSensorValue]
    var sensor: EnvironmentSensor
    let drawText: Bool = true
    let bottomTextHeight: CGFloat = 30
    let graphHeight: CGFloat = 200
    
    var body: some View {
        let dataStep = getDataStep(data: data)
        let valueWidth = getValueWidth(dataStep: dataStep)
        
        if #available(iOS 16.0, *) {
            let minMaxValue = getMinMax(
                data: data,
                dividers: sensor.sensorType.getGraphDivider()
            )
            
            Chart {
                ForEach(data, id: \.observedAt) { sensorValue in
                    LineMark(
                        x: .value("Time", sensorValue.observedAt),
                        y: .value("Value", sensorValue.value)
                    )
                }
                .interpolationMethod(.cardinal)
                .foregroundStyle(envGraphStrokeColor)
                //.symbol(.circle)
                ForEach(data, id: \.observedAt) { sensorValue in
                    AreaMark(
                        x: .value("Time", sensorValue.observedAt),
                        yStart: .value("Baseline", Double(minMaxValue.0)),
                        yEnd: .value("Value", sensorValue.value)
                    )
                    .interpolationMethod(.cardinal)
                    .foregroundStyle(Gradient(colors: [envGraphGradientFirstColor, envGraphGradientSecondColor]))
                }
                let dividers = getCombinedDividers(sensor)
                if !dividers.isEmpty {
                    ForEach(0..<dividers.count, id: \.self) { index in
                        let divider = dividers[index]
                        RuleMark(y: .value(divider.name, divider.value))
                            .annotation(position: .bottom,
                                        alignment: .bottomLeading) {
                                LocaleText(key: divider.name)
                                    .foregroundColor(.black)
                                    .environmentObject(localeViewModel)
                                //Annotation wraps its content initially and does't expand on finding a locale asynchronously / maxWidth doesn't help
                                    .frame(width: 350, alignment: .leading)
                            }.foregroundStyle(divider.getColor())
                            .lineStyle(StrokeStyle(lineWidth: 2, dash: [5, 5]))
                    }
                }
            }
            .chartXAxis {
                let dates = data.map(\.observedAt)
                if let minDate = dates.min(), let maxDate = dates.max() {
                    let totalMinutes = Calendar.current.dateComponents([.minute], from: minDate, to: maxDate).minute ?? 1
                    let interval = max(totalMinutes / 5, 1)
                    AxisMarks(values: Array(stride(from: minDate, to: maxDate, by: TimeInterval(interval * 60)))) { value in
                        if let date = value.as(Date.self) {
                            AxisValueLabel(format: .dateTime.hour().minute(), centered: true)
                        }
                    }
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .chartYScale(domain: minMaxValue.0...minMaxValue.1)
            .frame(height: 300)
            .padding()
        } else {
            ZStack() {
                GeometryReader { geo in
                    VStack{
                        if data.endIndex>0 {
                            HStack(spacing: 0) {
                                VStack(spacing: 0) {
                                    ForEach(0..<10, id: \.self) { vindex in
                                        let verticalText = drawText ? String(format: "%.2f",(10 - Double(vindex)) * dataStep) : ""
                                        HStack(spacing: 0) {
                                            Text(verticalText).font(.system(size: 10))
                                                .frame(height: graphHeight / 10, alignment: .trailing)
                                            Spacer().frame(width: 5)
                                        }
                                    }
                                }.frame(width: valueWidth)
                                ZStack {
                                    OSCAEnvironmentGraphGradientShape(data: data, dataStep: dataStep)
                                        .fill(LinearGradient(colors: [envGraphGradientFirstColor, envGraphGradientSecondColor],
                                                             startPoint: .top, endPoint: .bottom))
                                    OSCAEnvironmentGraphShape(data: data, dataStep: dataStep)
                                        .stroke(envGraphStrokeColor, lineWidth: envGraphStrokeWidth)
                                    OSCAEnvironmentCartesianShape(dataCount: data.count)
                                        .stroke(Color("EnvTextColor", bundle: OSCAEnvironmentUI.bundle))
                                }.frame(width: geo.size.width - valueWidth, height: graphHeight)
                            }.frame(height: graphHeight)
                            HStack(spacing: 0) {
                                Spacer().frame(minWidth: 0)
                                ForEach(0..<data.endIndex-2, id: \.self) { hindex in
                                    let horizontalText = drawText ? getDateString(date: data[hindex].observedAt) : ""
                                    Text(horizontalText).font(.system(size: 10))
                                        .frame(width: (geo.size.width - valueWidth) / 9, height: bottomTextHeight, alignment: .top)
                                }
                            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: drawText ? (geo.size.width ) / 18 : 0))
                        }
                    }
                }.frame(height: graphHeight + bottomTextHeight)
            }.padding(envGraphInternalPadding)
        }
    }
    
    func getDateString(date: Date) -> String {
        var formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        return formatter.string(from: date)
    }
    
    func getValueWidth(dataStep: CGFloat) -> CGFloat {
        let max = dataStep * 10
        var count: CGFloat = 1
        while (true) {
            if (max/(CGFloat(pow(10, count))))>=1 {
                count += 1
            } else {
                break
            }
        }
        
        
        return 8 * (count + 2.5)
    }
    
    func getCombinedDividers(_ sensor: EnvironmentSensor) -> [EnvironmentGraphDivider] {
        var dividers: [EnvironmentGraphDivider] = []
        
        if let typeDividers = sensor.sensorType.getGraphDivider() {
            dividers += typeDividers
        }
        if let sensorDividers = sensor.getGraphDivider() {
            dividers += sensorDividers
        }
        
        return dividers
    }
}

func getMinMax(
    data: [EnvironmentSensorValue],
    dividers: [EnvironmentGraphDivider]?
) -> (Int, Int) {
    var minValue = Int(data.min(by: { first, second in
        first.value < second.value
    })?.value ?? 0)

    var maxValue = Int(data.max(by: { first, second in
        first.value < second.value
    })?.value ?? 0)
    
    if let dividers = dividers {
        dividers.forEach { divider in
            let value = Int(divider.value)
            if (minValue > value) {
                minValue = value
            }
            if (maxValue < value) {
                maxValue = value
            }
        }
    }
    minValue -= 2
    maxValue += 2
    
    return (minValue, maxValue)
}
