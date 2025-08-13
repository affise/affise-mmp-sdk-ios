import AffiseAttributionLib
import Foundation

class TikTokUseCaseImpl: TikTokUseCase {

    private let CATEGORY: String = "tiktok"

    func sendEvent(_ eventName: String?, properties: [AnyHashable: Any]?, eventId: String? = nil) {
        guard let eventName = eventName else { return }
        UserCustomEvent(eventName: eventName, userData: eventId, category: CATEGORY)
            .internalAddRawParameters(properties)
            .send()
    }
}
