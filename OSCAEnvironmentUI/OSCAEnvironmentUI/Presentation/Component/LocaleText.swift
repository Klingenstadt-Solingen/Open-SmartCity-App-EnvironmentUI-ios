import SwiftUI

struct LocaleText: View {
    @EnvironmentObject var localeVM: OSCAEnvironmentLocaleViewModel
    var key: String
    @State var string: String = " "
    
    init(key: String) {
        self.key = key
        self.string = key
    }
    
    var body: some View {
        Text(string).task {
            await localeVM.getLocaleForKey(key, string: $string)
        }
    }
}
