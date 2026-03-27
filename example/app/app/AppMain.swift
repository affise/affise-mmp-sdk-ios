import SwiftUI

@available(iOS 14.0, *)
@main
struct AppMain: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) 
    private var appDelegate
    
    @StateObject 
    private var appSettings = AppSettings()
    @State private var isAlertPresented = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    init() {
        DispatchQueue.main.async {
            WebView.preload()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(appSettings)
                .onReceive(NotificationCenter.default.publisher(for: .showAppAlert)) { notification in
                    alertTitle = notification.userInfo?["title"] as? String ?? ""
                    alertMessage = notification.userInfo?["message"] as? String ?? ""
                    isAlertPresented = true
                }
                .alert(isPresented: $isAlertPresented) {
                    Alert(
                        title: Text(alertTitle),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
        }
    }
}

extension Notification.Name {
    static let showAppAlert = Notification.Name("showAppAlert")
}

func showAlert(title: String, message: String) {
    DispatchQueue.main.async {
        NotificationCenter.default.post(
            name: .showAppAlert,
            object: nil,
            userInfo: [
                "title": title,
                "message": message,
            ]
        )
    }
}