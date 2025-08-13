import Foundation

internal class AffiseTikTok : NSObject, AffiseModuleApiWrapper {
    typealias API = AffiseTikTokApi
    var api: API?
    var module: AffiseModules = .TikTok
}

extension AffiseTikTok : AffiseModuleTikTokApi {
    
    func hasModule() -> Bool { hasModule }
    
    func sendEvent(_ eventName: String?, properties: [AnyHashable: Any]?, eventId: String? = nil) {
        moduleApi?.sendEvent(eventName, properties: properties, eventId: eventId)
    }
}
