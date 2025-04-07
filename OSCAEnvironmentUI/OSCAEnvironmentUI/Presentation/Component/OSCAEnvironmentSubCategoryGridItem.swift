import SwiftUI
/**
 SubCategory Grid Item
 
 - Parameters:
  - itemTitle: Name of the SubCategory
  - itemId: Index of the SubCategory in the Grid
  - buttonAction: Calls an external function upon selecting the grid item
 */
struct OSCAEnvironmentSubCategoryGridItem: View {
    var item: EnvironmentSubCategory
    var itemId: Int
    var buttonAction: (Int) -> Void
    var cardColor = envDefColorBlue
    
    var body: some View {
        Button(action: {
            buttonAction(itemId)
        }) {
            VStack(alignment: .leading) {
                Spacer()
                OSCAEnvironmentWebImage(url: item.icon.icon.url,
                                        color: envSubCategoryGridButtonIconColor,
                                        width: envSubCategoryGridButtonIconSize,
                                        height: envSubCategoryGridButtonIconSize)
                LocaleText(key: item.name)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, maxHeight: envSubCategoryGridButtonTitleHeight, alignment: .leading)
                    .foregroundColor(envSubCategoryGridButtonTitleColor)
                    .font(.system(size: envSubCategoryGridButtonTitleSize).bold())
            }.aspectRatio(1, contentMode: .fill).padding(envGridItemContentPadding)
        }.buttonStyle(OSCAEnvironmentGridButtonStyle(buttonColor: cardColor))
    }
}
