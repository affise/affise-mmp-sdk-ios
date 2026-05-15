import AffiseAttributionLib

/**
 * Provider for parameter [ProviderType.ADID]
 */
internal class AdidProvider : StringPropertyProvider {
    
    private let advertisingIdManager: AdvertisingIdManager
    
    init(advertisingIdManager: AdvertisingIdManager) {
        self.advertisingIdManager = advertisingIdManager
    }

    public override func provide() -> String? {
        return advertisingIdManager.getAdvertisingId()
    }
    
    public override func getOrder() -> Float {
        29.1
    }

    public override func getKey() -> ProviderType? {
        ProviderType.ADID
    }
}
