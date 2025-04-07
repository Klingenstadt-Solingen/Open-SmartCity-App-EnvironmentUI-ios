import SwiftUI
import ParseCore

/**
 Category Tab Item
 
 - Parameters:
    - tabId: Index of the tab
    - tabSelected: Boolean used for deciding the background color based on the tab being selected
    - tabAction: Calls an external function upon selecting the tab
 */
struct OSCAEnvironmentCategoryTab: View {
    @EnvironmentObject var mainViewmodel: OSCAEnvironmentMainViewModel
    var tabId: Int
    var tabKey: String
    var tabAction: (Int) -> Void

    var body: some View {
        Button(action: {
            tabAction(tabId)
        }) {
            LocaleText(key: tabKey).foregroundColor(envCategoryTabTitleColor)
                .font(.system(size: envCategoryTabTitleSize).bold())
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(OSCAEnvironmentTabButtonStyle(tabCol: envTabColor()))
        .disabled(mainViewmodel.selectedTab == tabId)
    }
    
    func envTabColor() -> Color {
        if (mainViewmodel.selectedTab == tabId) {
            return envCategoryTabSelectedColor
        }
        else {
            return envCategoryTabUnselectedColor
        }
    }
}
