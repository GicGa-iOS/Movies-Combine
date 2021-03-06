import SwiftUI

///By wrapping views in a RootView, they will become the app's main / primary view. This will enable setting the statusBarStyle.
struct RootView<Content: View> : View {
    var content: Content

    init(@ViewBuilder content: () -> (Content)) {
        self.content = content()
    }

    var body:some View {
        EmptyView()
            .onAppear {
                UIApplication.shared.setHostingController(rootView: AnyView(content))
            }
    }
}
