import Foundation


@objc
public protocol AffiseTikTokApi: AffiseModuleApi {
    func sendEvent(_ eventName: String?, properties: [AnyHashable: Any]?, eventId: String?)
}
