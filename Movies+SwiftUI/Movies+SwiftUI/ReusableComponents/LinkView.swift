import SwiftUI
import WebKit

struct LinkView: View {
    var link: URL
    var body: some View {
        WebView(url: link)
    }
}

struct WebView: UIViewRepresentable {
    var url: URL
    func makeUIView(context: Context) -> WKWebView  {
        let webView = WKWebView()
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}

struct LinkView_Previews: PreviewProvider {
    static var previews: some View {
        LinkView(link: URL(string: "https://www.youtube.com/embed/d4K9Rzy2_DA")!)
    }
}
