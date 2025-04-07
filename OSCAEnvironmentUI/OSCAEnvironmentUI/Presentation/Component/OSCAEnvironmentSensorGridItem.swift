import SwiftUI

/**
 Sensor Grid Item
 
 - Parameters:
    - sensor: Sensor Value parse object used to get its value and unit
    - itemId: Index of the grid item
    - buttonAction: Calls an external function upon selecting a grid item
 */
struct OSCAEnvironmentSensorGridItem: View {
    var sensor: EnvironmentSensor
    var itemId: Int
    var buttonAction: (Int) -> Void
    
    var body: some View {
        Button(action: {
            buttonAction(itemId)
        }) {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .top, spacing: 0) {
                    OSCAEnvironmentWebImage(url: sensor.sensorType.icon.icon.url, color: envSensorGridIconColor, width: envSensorGridIconSize, height: envSensorGridIconSize)
                    Spacer()
                    Text(sensor.sensorType.unit).font(.system(size: envSensorGridUnitTitleSize).bold())
                        .foregroundColor(envSensorGridUnitTitleColor)
                        .frame(alignment: .topTrailing)
                }.frame(alignment: .top)
                Spacer()
                Text(sensor.value, format: .number.rounded(increment: 0.01)).font(.system(size: envSensorGridValueTitleSize).bold())
                    .foregroundColor(envSensorGridValueTitleColor)
                    .frame(alignment: .bottom)
                LocaleText(key: sensor.sensorType.name)
                    .lineLimit(1)
                    .font(.system(size: envSensorGridSensorTitleSize).bold())
                    .foregroundColor(envSensorGridSensorTitleColor)
                    .frame(alignment: .bottom)
            }.aspectRatio(1, contentMode: .fill).padding(envGridItemContentPadding)
        }.buttonStyle(OSCAEnvironmentGridButtonStyle(buttonColor: envSensorGridButtonColor))
    }
}
