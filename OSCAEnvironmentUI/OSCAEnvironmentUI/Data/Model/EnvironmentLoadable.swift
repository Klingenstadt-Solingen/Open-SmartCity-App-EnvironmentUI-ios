import SwiftUI

class OSCAEnvironmentLoadable: ObservableObject {
    @Published var loadingState = LoadingState.loading
    
    func errorToLoadingState(noResult: LocalizedStringKey = "no_result", _ block: () async throws -> Void) async {
        await updateLoadingState(.loading)
        do {
            try await block()
            await updateLoadingState(.loaded)
        } catch {
            switch error {
            case ApiError.ConnectionError:
                await updateLoadingState(.error(error: "connection_error"))
            case ApiError.NoResult:
                await updateLoadingState(.error(error: noResult))
            case ApiError.Timeout:
                await updateLoadingState(.error(error: "timeout"))
            case ApiError.CastError:
                await updateLoadingState(.error(error: "cast_error"))
            default:
#if DEBUG
                print("UNKNOWN ERROR: \(error)")
#endif
                await updateLoadingState(.error(error: "something_went_wrong"))
            }
        }
    }
    
    func errorNoLoadingState(_ block: () async throws -> Void) async {
        do {
            try await block()
        } catch {}
    }
    
    func errorGetLoadingState(_ block: () async throws -> Void) async -> LoadingState {
        do {
            try await block()
            return .loaded
        } catch {
            switch error {
            case ApiError.ConnectionError:
                return .error(error: "connection_error")
            case ApiError.NoResult:
                return .error(error: "no_result")
            case ApiError.Timeout:
                return .error(error: "timeout")
            case ApiError.CastError:
                return .error(error: "cast_error")
            default:
                return .error(error: "something_went_wrong")
            }
        }
    }
    
    func updateLoadingState(_ loadingState: LoadingState) async {
        guard self.loadingState != loadingState else { return }
        
        await MainActor.run {
            self.loadingState = loadingState
        }
    }
    
   
}
