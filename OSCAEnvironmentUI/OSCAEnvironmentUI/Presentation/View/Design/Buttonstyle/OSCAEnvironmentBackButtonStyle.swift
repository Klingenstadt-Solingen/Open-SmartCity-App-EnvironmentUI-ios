import SwiftUI

/**
 ButtonStyle of a Grid Item
 */
struct OSCAEnvironmentBackButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(Rectangle().foregroundColor(Color.clear))
                .brightness(configuration.isPressed ? envDefSelectionBrightness : 0.0)
    }
}
