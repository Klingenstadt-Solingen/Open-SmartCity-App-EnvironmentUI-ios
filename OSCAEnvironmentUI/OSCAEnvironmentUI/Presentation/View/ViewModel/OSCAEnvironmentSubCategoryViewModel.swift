import Foundation

/**
 Responsible for fetching SubCategories
 */
class OSCAEnvironmentSubCategoryViewModel: OSCAEnvironmentLoadable {
    @Published var subCategories = [EnvironmentSubCategory]()
    
    func fetchSubCategories(categoryId: String) async {
        await errorToLoadingState {
            let result = try await OSCAEnvironmentSubCategoryRepositoryImpl.getSubCategoriesByCategoryId(categoryId: categoryId, skip: 0)
            await MainActor.run() {
                subCategories = result
            }
        }
    }
    
    func fetchMoreSubCategories(categoryId: String) async {
        await errorNoLoadingState {
            let result = try await OSCAEnvironmentSubCategoryRepositoryImpl.getSubCategoriesByCategoryId(categoryId: categoryId, skip: subCategories.endIndex)
            await MainActor.run() {
                subCategories.append(contentsOf: result)
            }
        }
    }
    
}
