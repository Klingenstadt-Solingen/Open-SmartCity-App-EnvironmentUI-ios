import SwiftUI

/**
 Station List Tab View which enables showing the list or a map of sensor stations
 
 - Parameters:
    - selectedTab: Index of the tab
    - changeTab: Calls an external function upon selecting a tab
    - tabTitles: Text on each tab
 */
struct OSCAEnvironmentStationListTabs: View {
    var selectedTab: Int
    var changeTab: (Int) -> ()
    let tabTitles = [LocalizedStringKey("list"),
                     LocalizedStringKey("map")]
    
    var body: some View {
        HStack {
            ForEach(0..<2) { index in
                Button(action: {
                    changeTab(index)
                }) {
                    Text(tabTitles[index], bundle: OSCAEnvironmentUI.bundle)
                        .foregroundColor(envStationListTabItemTitleColor)
                        .font(.system(size: envStationListTabItemTitleSize).bold())
                        .frame(maxWidth: .infinity, maxHeight: envStationListTabItemHeight)
                }.background(RoundedRectangle(cornerRadius: envStationListTabItemCornerRadius)
                    .foregroundColor(tabColor(index: index)))
            }
        }.padding(envStationListTabPadding)
    }
    
    /**
     Determines the color based on the tab being selected or not
     */
    func tabColor(index: Int) -> Color {
        if selectedTab == index {
            return envStationListTabItemSelectedColor
        } else {
            return envStationListTabItemUnselectedColor
        }
    }
}
