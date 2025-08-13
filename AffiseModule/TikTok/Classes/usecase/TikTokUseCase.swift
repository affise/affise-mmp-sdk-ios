import Foundation
import AffiseAttributionLib


protocol TikTokUseCase {
    func sendEvent(_ eventName: String?, properties: [AnyHashable: Any]?, eventId: String?)
}
