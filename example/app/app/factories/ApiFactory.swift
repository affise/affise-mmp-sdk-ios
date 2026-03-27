import AffiseAttributionLib
import Foundation

struct ApiAction {
    let title: String
    let action: () -> Void
}

final class ApiFactory {
    func createActions(
        output: @escaping (String) -> Void,
        appSettings: AppSettings
    ) -> [ApiAction] {
        return [
            ApiAction(title: "Debug: validate") {
                output("validate: requesting...")
                Affise.Debug.validate { status in
                    output("validate: \(status)")
                }
            },
            ApiAction(title: "Debug: version") {
                output("version: \(Affise.Debug.version())")
            },
            ApiAction(title: "addPushToken") {
                Affise.addPushToken("new_token", .APPLE)
            },
            ApiAction(title: "setOfflineModeEnabled") {
                Affise.setOfflineModeEnabled(!Affise.isOfflineModeEnabled())
                appSettings.isOfflineMode = Affise.isOfflineModeEnabled()
                output("isOfflineModeEnabled: \(appSettings.isOfflineMode)")
            },
            ApiAction(title: "isOfflineModeEnabled") {
                let value = Affise.isOfflineModeEnabled()
                output("isOfflineModeEnabled: \(value)")
            },
            ApiAction(title: "setBackgroundTrackingEnabled") {
                Affise.setBackgroundTrackingEnabled(!Affise.isBackgroundTrackingEnabled())
                output("isBackgroundTrackingEnabled: \(Affise.isBackgroundTrackingEnabled())")
            },
            ApiAction(title: "isBackgroundTrackingEnabled") {
                let value = Affise.isBackgroundTrackingEnabled()
                output("isBackgroundTrackingEnabled: \(value)")
            },
            ApiAction(title: "setTrackingEnabled") {
                Affise.setTrackingEnabled(!Affise.isTrackingEnabled())
                output("isTrackingEnabled: \(Affise.isTrackingEnabled())")
            },
            ApiAction(title: "isTrackingEnabled") {
                let value = Affise.isTrackingEnabled()
                output("isTrackingEnabled: \(value)")
            },
            ApiAction(title: "getReferrer") {
                Affise.getReferrerUrl { value in
                    output("getReferrer: \(value ?? "nil")")
                }
            },
            ApiAction(title: "getReferrerValue") {
                Affise.getReferrerUrlValue(.AD_ID) { value in
                    output("getReferrerValue: \(value ?? "nil")")
                }
            },
            ApiAction(title: "getDeferredDeeplink") {
                Affise.getDeferredDeeplink { value in
                    output("getDeferredDeeplink: \(value ?? "nil")")
                }
            },
            ApiAction(title: "getDeferredDeeplinkValue") {
                Affise.getDeferredDeeplinkValue(.AD_ID) { value in
                    output("getDeferredDeeplinkValue: \(value ?? "nil")")
                }
            },
            ApiAction(title: "getStatus") {
                output("getStatus: requesting...")
                Affise.Module.getStatus(.Status) { keyValue in
                    let value = keyValue
                        .map { "key = \($0.key); value = \($0.value ?? "nil" )" }
                        .joined(separator: "\n")
                    output("getStatus: \(value)")
                }
            },
            ApiAction(title: "getModulesInstalled") {
                let value = Affise.Module.getModulesInstalled()
                    .map(\.description)
                    .joined(separator: ", ")
                output("getModulesInstalled: [ \(value)]")
            },
            ApiAction(title: "getRandomUserId") {
                let value = Affise.getRandomUserId()
                output("getRandomUserId: \(value ?? "nil")")
            },
            ApiAction(title: "getRandomDeviceId") {
                let value = Affise.getRandomDeviceId()
                output("getRandomDeviceId: \(value ?? "nil")")
            },
            ApiAction(title: "getProviders") {
                let providerType = ProviderType.ADID
                let value = Affise.getProviders()[providerType]
                output("getProviders: \(providerType.provider) = \(String(describing: value))")
            },
            ApiAction(title: "isFirstRun") {
                let value = Affise.isFirstRun()
                output("isFirstRun: \(value)")
            },
        ]
    }
}
