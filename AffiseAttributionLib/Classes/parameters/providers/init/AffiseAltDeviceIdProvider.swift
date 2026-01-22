
/**
 * Provider for parameter [ProviderType.AFFISE_ALT_DEVICE_ID]
 *
 * @property useCase to retrieve affise alt device id
 */
class AffiseAltDeviceIdProvider: StringPropertyProvider {
    private let useCase: AppUUIDs
    
    init(useCase: AppUUIDs) {
        self.useCase = useCase
    }
    
    override func provide() -> String? {
        return useCase.getAffiseAltDeviseId()
    }
    
    public override func getOrder() -> Float {
        28.0
    }

    public override func getKey() -> ProviderType? {
        ProviderType.AFFISE_ALT_DEVICE_ID
    }
}
