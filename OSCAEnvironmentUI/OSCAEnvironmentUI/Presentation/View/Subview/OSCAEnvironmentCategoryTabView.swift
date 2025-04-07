import SwiftUI

/**
 Tab View showing Categories
 */
struct OSCAEnvironmentCategoryTabView: View {
    @EnvironmentObject var navigator: OSCAEnvironmentNavigator
    @EnvironmentObject var mainViewmodel: OSCAEnvironmentMainViewModel

    var body: some View {
        HStack(spacing: envCategoryTabSpacing) {
            ForEach(0..<mainViewmodel.categories.count, id: \.self) { index in
                OSCAEnvironmentCategoryTab(tabId: index, tabKey: mainViewmodel.categories[index].name, tabAction: tabAction)
            }
        }.frame(maxWidth: .infinity)
    }
    
    func tabAction(tabId: Int) {
        mainViewmodel.selectedTab = tabId
        
        navigator.navigate(route: .subCategoryRoute(categoryId: mainViewmodel.categories[tabId].objectId ?? "", cardColor: Color(hex:  mainViewmodel.categories[tabId].color)))
    }
}
