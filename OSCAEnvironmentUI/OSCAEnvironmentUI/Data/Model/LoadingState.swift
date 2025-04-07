import SwiftUI

enum LoadingState: Equatable {
    case loading
    case loaded
    case error(error: LocalizedStringKey)
}
