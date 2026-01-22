import AffiseAttributionLib
import Foundation

@objc(AffiseAdvertisingModule)
public final class AdvertisingModule: AffiseModule, AffiseAdvertisingApi {

    public override var version: String { BuildConfig.AFFISE_VERSION }

    private lazy var advertisingIdManager: AdvertisingIdManager = AdvertisingIdManagerImpl()
    
    private lazy var adidProvider: Provider = AdidProvider(advertisingIdManager: advertisingIdManager)

    private var newProviders: [Provider] = []

    override public func providers() -> [Provider] {
        newProviders
    }

    public func startModule() {
        advertisingIdManager.initialize()
        
        newProviders = [
            adidProvider
        ]
    }

    public func getAdvertisingId() -> String? {
        return advertisingIdManager.getAdvertisingId()
    }
}
