import SwiftUI


@available(iOS 13.0, *)
struct SettingsView: View {
    @EnvironmentObject private var appSettings: AppSettings
    
    var body: some View {
        VStack(spacing: 12) {
            TextField(
                "Domain (restart needed)",
                text: $appSettings.domain
            )
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding(.horizontal, 12)
                .frame(height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.35), lineWidth: 1)
                )
            
            TextField(
                "App ID",
                text: $appSettings.appId
            )
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding(.horizontal, 12)
                .frame(height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.35), lineWidth: 1)
                )
            
            TextField(
                "Secret key",
                text: $appSettings.secretKey
            )
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding(.horizontal, 12)
                .frame(height: 44)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.35), lineWidth: 1)
                )
            
            Toggle("Production mode", isOn: $appSettings.isProductionMode)
            Toggle("Offline Mode", isOn: $appSettings.isOfflineMode)
            Toggle("Debug Request", isOn: $appSettings.isDebugRequest)
            Toggle("Debug Response", isOn: $appSettings.isDebugResponse)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}


@available(iOS 13.0, *)
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
