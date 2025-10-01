import Foundation

internal protocol AffiseApi {
    var initProperties: AffiseInitProperties {get}
    var firstAppOpenUseCase: FirstAppOpenUseCase {get}
    var sessionManager: SessionManager {get}
    var eventsManager: EventsManager {get}
    var storeEventUseCase: StoreEventUseCase {get}
    var preferences: UserDefaults {get}
    var logsManager: LogsManager {get}
    var webBridgeManager: WebBridgeManager {get}
    var deeplinkManager: DeeplinkManager {get}
    var initPropertiesStorage: InitPropertiesStorage {get}
    var preferencesUseCase: PreferencesUseCase {get}
    var postBackModelFactory: PostBackModelFactory {get}
    var retrieveReferrerUseCase: RetrieveReferrerUseCase {get}
    var retrieveReferrerOnServerUseCase: RetrieveReferrerOnServerUseCase {get}
    var moduleManager: AffiseModuleManager {get}
    var storeInternalEventUseCase: StoreInternalEventUseCase {get}
    var debugValidateUseCase: DebugValidateUseCase {get}
    var debugNetworkUseCase: DebugNetworkUseCase {get}
    var immediateSendToServerUseCase: ImmediateSendToServerUseCase {get}
    var pushTokenUseCase: PushTokenUseCase {get}

    func isInitialized() -> Bool
}
