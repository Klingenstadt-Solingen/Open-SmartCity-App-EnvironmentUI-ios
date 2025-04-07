import SwiftUI

struct OSCAEnvironmentMarkerSheet: View {
    var name: String
    
    var body: some View {
        VStack() {
            Text(verbatim: name)
                .font(.system(size: 18))
                .foregroundColor(Color("EnvTextTitleColor", bundle: OSCAEnvironmentUI.bundle))
                .padding(.horizontal, 10)
        }
    }
}
