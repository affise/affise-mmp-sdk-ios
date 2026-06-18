import AffiseAttributionLib

/**
 * Provider for parameter [ProviderType.APPLICATION_TRACKING_ENABLED]
 */
internal class ApplicationTrackingEnabledProvider: BooleanPropertyProvider {

    private let advertisingIdManager: AdvertisingIdManager

    init(advertisingIdManager: AdvertisingIdManager) {
        self.advertisingIdManager = advertisingIdManager
    }

    public override func provide() -> Bool? {
        return advertisingIdManager.isApplicationTrackingEnabled()
    }

    public override func getOrder() -> Float {
        29.3
    }

    public override func getKey() -> ProviderType? {
        ProviderType.APPLICATION_TRACKING_ENABLED
    }
}
