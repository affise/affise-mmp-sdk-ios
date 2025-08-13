import Foundation
import AffiseAttributionLib

@objc(AffiseAppsFlyerModule)
public final class AppsFlyerModule: AffiseModule, AffiseAppsFlyerApi {
    
    public override var version: String { BuildConfig.AFFISE_VERSION }
    
    lazy var useCase: AppsFlyerUseCase = AppsFlyerUseCaseImpl()
    
    public override func start() {
    }
    
    public func logEvent(_ eventName: String, _ eventValues: [String: Any]) {
        useCase.logEvent(eventName, eventValues)
    }
}
