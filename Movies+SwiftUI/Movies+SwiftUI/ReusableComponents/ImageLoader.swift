import SwiftUI
import NukeUI

struct ImageLoader {
    // This is where the image view is created.
    static func makeImage(url: URL) -> some View {
        LazyImage(source: url, resizingMode: .aspectFit)
    }
}
