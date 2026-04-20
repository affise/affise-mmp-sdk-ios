import Foundation

internal struct AffiseInternal {
    
    private static let queue = DispatchQueue(label: "com.affise.AffiseInternal")

    static func start(
        initProperties: AffiseInitProperties,
        app: UIApplication,
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) {
        queue.sync {
            if (Affise.api == nil) {
                do {
                    Affise.api = try AffiseComponent(app: app, initProperties: initProperties, launchOptions: launchOptions)
                    initProperties.onInitSuccessHandler?()
                } catch {
                    debugPrint("Affise SDK start error: \(error.localizedDescription)")
                    initProperties.onInitErrorHandler?(error)
                }
            } else {
                initProperties.onInitErrorHandler?(AffiseError.alreadyInitialized)
                debugPrint(AffiseError.ALREADY_INITIALIZED)
            }
        }
    }

    /**
     * Store and send [event]
     */
    static func sendEvent(_ event: Event) {
        Affise.api?.storeEventUseCase.storeEvent(event: event)
    }
    /**
     * Send now [event]
     */
    static func sendEventNow(_ event: Event, _ success: @escaping OnSendSuccessCallback, _ failed: @escaping OnSendFailedCallback) {
        Affise.api?.immediateSendToServerUseCase.sendNow(event: event, success: success, failed: failed)
    }

    
    /**
     * Store internal send
     */
    static func sendInternalEvent(_ event: InternalEvent) {
        Affise.api?.storeInternalEventUseCase.storeInternalEvent(event: event)
    }
}
