import SwiftUI

/**
 Displays a Text under the Backbutton
 
 - Parameters:
    - subtitle: Text shown in the Subtitle
 */
struct OSCAEnvironmentSubtitle: View {
    var subtitleString: String?
    var subtitleKey: LocalizedStringKey?
    var padding = true
    
    var body: some View {
        HStack {
            if let key = subtitleKey {
                Text(key, bundle : OSCAEnvironmentUI.bundle).font(.system(size: envSubtitleSize))
                    .foregroundColor(envSubtitleColor)
            }
            if let string = subtitleString {
                Text(verbatim: string).font(.system(size: envSubtitleSize))
                    .foregroundColor(envSubtitleColor)
            }
            Spacer()
        }.padding(padding ? envSubtitleLeadingPadding : EdgeInsets(.zero)).padding(envSubtitleTopPadding)
    }
}
