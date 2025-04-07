import SwiftUI

/**
 ButtonStyle of a List Button
 */
struct OSCAEnvironmentStationListButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(RoundedRectangle(cornerRadius: envStationListButtonCornerRadius)
                .foregroundColor(envStationListItemColor))
            .brightness(configuration.isPressed ? envDefSelectionBrightness : 0.0)
    }
}

