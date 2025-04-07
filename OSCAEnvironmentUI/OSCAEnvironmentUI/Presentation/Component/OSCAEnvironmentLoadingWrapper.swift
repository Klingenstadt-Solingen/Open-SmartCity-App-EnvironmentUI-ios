import SwiftUI

/**
 Wraps content inside of a loading circle until data is loaded
 
 - Parameters:
 - width: Width of the Wrapper
 - height: Height of the Wrapper
 */
struct OSCAEnvironmentLoadingWrapper<Content> : View where Content : View {
    @Environment(\.refresh) private var refresh
    var loadingStates: [LoadingState]
    var width: CGFloat? = nil
    var height: CGFloat? = nil
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        switch getStatus(loadingStates: loadingStates) {
        case .loading:
            HStack() {
                Spacer()
                VStack() {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                Spacer()
            }.frame(width: width, height: height)
        case .error(let error):
            HStack() {
                Spacer()
                VStack() {
                    Spacer()
                    Text(error, bundle: OSCAEnvironmentUI.bundle)
                    if let refresh = refresh {
                        Button(action: {
                            Task {
                                await refresh()
                            }
                        }) {
                            Text("try_again", bundle: OSCAEnvironmentUI.bundle).padding(5)
                        }.buttonStyle(OSCAEnvironmentGridButtonStyle(buttonColor: envDefColorBlue))
                    }
                    Spacer()
                }
                Spacer()
            }.frame(width: width, height: height)
        default:
            content()
        }
    }
    
    /**
     Checks each loadable if it is loaded
     */
    func getStatus(loadingStates: [LoadingState]) -> LoadingState {
        for loadingState in loadingStates {
            switch loadingState {
            case .error(let errorMessage):
                return .error(error: errorMessage)
            case .loading:
                return .loading
            default:
                break
            }
        }
        
        return .loaded
    }
}

extension OSCAEnvironmentLoadingWrapper {
    init(
        loadingStates: LoadingState...,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(loadingStates: loadingStates, width: width, height: height, content: content)
    }
}
