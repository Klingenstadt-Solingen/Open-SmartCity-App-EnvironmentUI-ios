import SwiftUI

/**
 Grid View showing SubCategories related to a Category
 
 - Parameters:
 - categoryId: objectId of the selected Category
 */
struct OSCAEnvironmentSubCategoryGridView: View {
    @EnvironmentObject var navigator: OSCAEnvironmentNavigator
    @EnvironmentObject var mainVM: OSCAEnvironmentMainViewModel
    @StateObject var subCategoryVM = OSCAEnvironmentSubCategoryViewModel()
    var categoryId: String
    var cardColor: Color
    
    var body: some View {
        ZStack() {
                OSCAEnvironmentLoadingWrapper(loadingStates: subCategoryVM.loadingState) {
                    OSCAEnvironmentGrid(itemCount: subCategoryVM.subCategories.endIndex, createGridItem: createGridItem, fetchMore: { await subCategoryVM.fetchMoreSubCategories(categoryId: categoryId )} )
                }.task(id: "\(categoryId)") {
                    await subCategoryVM.fetchSubCategories(categoryId: categoryId)
                }.refreshable {
                    await subCategoryVM.fetchSubCategories(categoryId: categoryId)
                }
            VStack() {
                Spacer()
                HStack() {
                    Spacer()
                    Button(action: { mapButtonAction() }) {
                        Image("ic_map_with_marker", bundle: OSCAEnvironmentUI.bundle)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color("EnvTextTitleColor", bundle: OSCAEnvironmentUI.bundle))
                            .frame(maxWidth: 35, maxHeight: 35)
                            .padding(10)
                    }
                    .background(RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("EnvCategoryTabUnselectedColor", bundle: OSCAEnvironmentUI.bundle)))
                }
            }
        }
    }
    
    @ViewBuilder func createGridItem(itemId: Int) -> some View {
        OSCAEnvironmentSubCategoryGridItem(
            item: subCategoryVM.subCategories[itemId],
            itemId: itemId,
            buttonAction: buttonAction,
            cardColor: cardColor
        )
    }
    
    func buttonAction(subCategoryId: Int) {
        navigator.navigate(route: .stationRoute(backButtonKey: subCategoryVM.subCategories[subCategoryId].name,
                                                subCategoryId: subCategoryVM.subCategories[subCategoryId].objectId ?? "", selectedTab: 0))
    }
    
    func mapButtonAction() {
        navigator.navigate(route: .fullscreenMapRoute)
    }
}
