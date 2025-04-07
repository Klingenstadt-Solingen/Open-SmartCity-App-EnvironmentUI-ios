import SwiftUI

struct OSCAEnvironmentSensorValue: View {
    var sensor: EnvironmentSensor?
    
    var body: some View {
        HStack(alignment: .top, spacing: 5) {
            Text(sensor?.value ?? 0.0, format: .number.rounded(increment: 0.01))
                .font(.system(size: envSensorDetailValueTitleSize).bold())
                .foregroundColor(envSensorDetailValueTitleColor)
            Text(sensor?.sensorType.unit ?? "")
                .font(.system(size: envSensorDetailUnitTitleSize))
                .foregroundColor(envSensorDetailUnitTitleColor)
        }
    }
}

#Preview {
    OSCAEnvironmentSensorValue()
}
