import Foundation
import AffiseAttributionLib

@objc(AffiseTikTokModule)
public final class TikTokModule: AffiseModule, AffiseTikTokApi {
    
    public override var version: String { BuildConfig.AFFISE_VERSION }
    
    lazy var useCase: TikTokUseCase = TikTokUseCaseImpl()
    
    public override func start() {
    }
    
    public func sendEvent(_ eventName: String?, properties: [AnyHashable: Any]?, eventId: String? = nil) {
        useCase.sendEvent(eventName, properties: properties, eventId: eventId)
    }
}
