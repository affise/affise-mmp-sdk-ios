import Foundation
import WebKit


internal class WebViewUseCase {

    private let WEB_VIEW_USER_AGENT_KEY = "WEB_VIEW_USER_AGENT"

    private let preferences: UserDefaults

    init(preferences: UserDefaults) {
        self.preferences = preferences
    }

    func initialize() {
        DispatchQueue.main.async {
            let userAgent = WKWebView().value(forKey: "userAgent") as? String
            self.preferences.set(userAgent, forKey: self.WEB_VIEW_USER_AGENT_KEY)
        }
    }


   func getUserAgent() -> String {
       return preferences.string(forKey: WEB_VIEW_USER_AGENT_KEY) ?? ""
   }
}
