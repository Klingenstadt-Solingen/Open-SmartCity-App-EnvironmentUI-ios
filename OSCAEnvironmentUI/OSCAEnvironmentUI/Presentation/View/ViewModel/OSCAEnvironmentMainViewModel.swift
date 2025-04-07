import Foundation

/**
 Responsible for fetching Sensor Categories
 */
class OSCAEnvironmentMainViewModel: OSCAEnvironmentLoadable {
    @Published var categories = [EnvironmentCategory]()
    @Published var selectedTab = 0

    func fetchCategories() async {
        await errorToLoadingState {
            let result = try await OSCAEnvironmentCategoryRepositoryImpl.getCategories()
            await MainActor.run {
                categories = result
            }
        }
    }
}
