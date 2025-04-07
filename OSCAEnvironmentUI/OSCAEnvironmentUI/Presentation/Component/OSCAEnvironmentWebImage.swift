import SwiftUI
import ParseCore
import SDWebImageSwiftUI

/**
 Displays an Image asynchronously

 - Parameters:
    - icon: Icon object to get the url from
    - color: Color of the Image
    - width: Width of the Image
    - height: Height of the Image
 */
struct OSCAEnvironmentWebImage: View {
    var url: String?
    var color: Color = Color.white
    var width: CGFloat = 50
    var height: CGFloat = 50


    var body: some View {
        if url != nil {
            WebImage(url: URL(string: getHttps(url!)))
                .resizable()
                .renderingMode(.template)
                .placeholder{
                    ProgressView()
                }
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: width, maxHeight: height)
                .foregroundColor(color)
        } else {
            Spacer().frame(maxWidth: width, maxHeight: height)
        }
    }

    // TODO: ADD HTTPS TO URL UNTIL ISSUE IS RESOLVED WITH PARSE SERVER
    func getHttps(_ url: String) -> String {
        var https = url
        if (!url.starts(with: "https")) {
            https = url.replacingOccurrences(of: "http", with: "https")
        }
        return https
    }
}
