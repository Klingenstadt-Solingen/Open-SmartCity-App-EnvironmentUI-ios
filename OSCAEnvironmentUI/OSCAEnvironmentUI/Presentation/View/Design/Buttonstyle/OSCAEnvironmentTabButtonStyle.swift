import SwiftUI

/**
 ButtonStyle of a Tab Item

 - Parameters:
    - tabColor: Background color of the Button
 */
struct OSCAEnvironmentTabButtonStyle: ButtonStyle {
    var tabCol: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(OSCAEnvironmentCategoryTabShape()
                .fill(tabCol)
                .shadow(radius: envCategoryTabShadowRadius)
                .mask(Rectangle().padding(envCategoryTabMaskPadding)))
            .brightness(configuration.isPressed ? envCategoryTabButtonPressedBrightness : 0.0)
    }
}
