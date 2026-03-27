import SwiftUI
import WebKit
import AffiseAttributionLib


@available(iOS 13.0, *)
struct WebView: View {
    static func preload() {
        _ = WebContainerView.sharedWebView
    }
    
    var body: some View {
        WebContainerView()
    }
}

@available(iOS 13.0, *)
private struct WebContainerView: UIViewRepresentable {
    static let sharedWebView: WKWebView = {
        let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.scrollView.contentInset = .zero
        webView.scrollView.scrollIndicatorInsets = .zero
        
        if let indexURL = Bundle.main.url(forResource: "index", withExtension: "html") {
            webView.loadFileURL(indexURL, allowingReadAccessTo: indexURL)
        }
        
        Affise.registerWebView(webView)
        return webView
    }()
    
    func makeUIView(context: Context) -> WKWebView {
        WebContainerView.sharedWebView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}


@available(iOS 13.0, *)
struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView()
    }
}
