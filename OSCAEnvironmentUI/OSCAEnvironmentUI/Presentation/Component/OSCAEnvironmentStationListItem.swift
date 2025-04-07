import SwiftUI

/**
 Item shown in the Station List
 
 - Parameters:
    - stationTitle: Text shown on the list item
    - stationId: Index of the list item
    - buttonAction: Calls an external function upon selecting a list item
 */
struct OSCAEnvironmentStationListItem: View {
    var stationTitle: String
    var stationId : Int
    var buttonAction: (Int) -> ()
    
    var body: some View {
        Button(action: {
            buttonAction(stationId)
        }) {
            HStack {
                Image("ic_right", bundle: OSCAEnvironmentUI.bundle).resizable()
                    .frame(width: envStationListIconWidth , height: envStationListIconHeight)
                    .padding(envStationListItemPadding)
                Text(stationTitle).frame(height: envStationListItemHeight, alignment: .leading)
                    .font(.system(size: envStationListItemTitleFontSize).bold())
                Spacer()
            }
        }.buttonStyle(OSCAEnvironmentStationListButtonStyle())
    }
}
