import Foundation

internal struct AffiseInternal {
    
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
