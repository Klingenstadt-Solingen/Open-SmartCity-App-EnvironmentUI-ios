import SwiftUI
import Combine

/**
 Main SwiftUI View of the Environment Module
 */
struct OSCAEnvironmentMainView: View {
    @EnvironmentObject var navigator: OSCAEnvironmentNavigator
    @EnvironmentObject var localeVM: OSCAEnvironmentLocaleViewModel
    @StateObject var mainViewModel = OSCAEnvironmentMainViewModel()
    
    var body: some View {
        OSCAEnvironmentLoadingWrapper(loadingStates: [localeVM.loadingState, mainViewModel.loadingState]) {
            VStack(spacing: 0) {
                if navigator.navRoute != .fullscreenMapRoute {
                    OSCAEnvironmentCategoryTabView().environmentObject(mainViewModel).frame(maxHeight: envCategoryTabHeight)
                }
                OSCAEnvironmentNavigationView().environmentObject(mainViewModel)
            }.padding(envMainPadding).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .onAppear() {
                    if let category = mainViewModel.categories.first {
                        navigator.navigate(route: .subCategoryRoute(categoryId: category.objectId ?? "", cardColor: Color(hex: category.color)))
                    }
                }
        }.task(id: "\(Locale.preferredLanguages.first ?? "en-EN")") {
            await localeVM.fetchLocales()
            if mainViewModel.loadingState == .loading {
                await mainViewModel.fetchCategories()
            }
        }.refreshable {
            if case .error(_) = localeVM.loadingState {
                await localeVM.fetchLocales()
            }
            if case .error(_) = mainViewModel.loadingState {
                await mainViewModel.fetchCategories()
            }
        }
        .onChange(of: Locale.preferredLanguages.first) { language in
            localeVM.language = language ?? "en-EN"
        }
    }
}
