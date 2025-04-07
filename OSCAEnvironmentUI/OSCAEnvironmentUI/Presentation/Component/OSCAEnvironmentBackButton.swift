import SwiftUI

/**
 BackButton used to navigate backwards inside the Environment Module
 
 - Parameters:
    - backButtonKey: Text on the BackButton
 */
struct OSCAEnvironmentBackButton: View {
    @EnvironmentObject var navigator: OSCAEnvironmentNavigator
    var backButtonKey: String?
    var backButtonString: String?
    
    var body: some View {
        HStack {
            Button(action: {
                backButtonAction()
            }) {
                HStack {
                    Image("ic_left", bundle: OSCAEnvironmentUI.bundle).resizable()
                        .frame(width: envBackButtonIconWidth ,height: envBackButtonIconHeight)
                    if let key = backButtonKey {
                        LocaleText(key: key).font(.system(size: envBackButtonTitleSize).bold())
                            .foregroundColor(envBackButtonTitleColor)
                    }
                    if let string = backButtonString {
                        Text(verbatim: string).font(.system(size: envBackButtonTitleSize).bold())
                            .foregroundColor(envBackButtonTitleColor)
                    }
                }.lineLimit(1)
            }.buttonStyle(OSCAEnvironmentBackButtonStyle()).frame(alignment: .leading)
            Spacer()
        }.padding(envBackButtonPadding)
    }
    
    func backButtonAction() {
        navigator.navigateBack()
    }
}
