import AffiseAttributionLib

/**
 *  Provider for parameter [ProviderType.DEVICE_MANUFACTURER]
 */
class DeviceManufacturerProvider: StringPropertyProvider {
    
    override func provide() -> String? {
        return "Apple"
    }
    
    public override func getOrder() -> Float {
        24.0
    }

    public override func getKey() -> ProviderType? {
        ProviderType.DEVICE_MANUFACTURER
    }
}
