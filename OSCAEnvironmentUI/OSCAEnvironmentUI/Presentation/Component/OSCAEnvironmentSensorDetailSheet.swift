import SwiftUI
import MapKit

struct OSCAEnvironmentSensorDetailSheet: View {
    var sensor: EnvironmentSensor
    
    var body: some View {
        VStack(spacing: 0) {
            HStack() {
                LocaleText(key: sensor.sensorType.name)
                    .font(.system(size: envBackButtonTitleSize).bold())
                    .foregroundColor(envBackButtonTitleColor)
                    .padding(.top, 15)
                Spacer()
            }
            OSCAEnvironmentSensorDetail(sensor: sensor, subtitlePadding: false)
        }
        .padding(envMainPadding)
    }
}
