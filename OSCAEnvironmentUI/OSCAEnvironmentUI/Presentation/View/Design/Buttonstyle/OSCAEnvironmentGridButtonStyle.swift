import Foundation
import SwiftUI

/**
 ButtonStyle of a Grid Item
 
 - Parameters:
    - buttonColor: Background color of the Button
 */
struct OSCAEnvironmentGridButtonStyle: ButtonStyle {
    var buttonColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(RoundedRectangle(cornerRadius: envGridButtonCornerRadius)
                .foregroundColor(buttonColor))
            .brightness(configuration.isPressed ? envDefSelectionBrightness : 0.0)
    }
}
