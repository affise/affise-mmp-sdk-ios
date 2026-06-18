import AffiseAttributionLib

/**
 * Provider for parameter [ProviderType.ADVERTISER_TRACKING_ENABLED]
 */
internal class AdvertiserTrackingEnabledProvider: BooleanPropertyProvider {

    private let advertisingIdManager: AdvertisingIdManager

    init(advertisingIdManager: AdvertisingIdManager) {
        self.advertisingIdManager = advertisingIdManager
    }

    public override func provide() -> Bool? {
        return advertisingIdManager.isAdvertiserTrackingEnabled()
    }

    public override func getOrder() -> Float {
        29.2
    }

    public override func getKey() -> ProviderType? {
        ProviderType.ADVERTISER_TRACKING_ENABLED
    }
}
