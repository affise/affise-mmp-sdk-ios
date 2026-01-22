import Foundation

/**
 * Provider for parameter [ProviderType.AFFISE_DEVICE_ID]
 *
 * @property useCase to retrieve affise device id
 */
public class AffiseDeviceIdProvider: StringPropertyProvider {
    private let useCase: AppUUIDs
    
    init(useCase: AppUUIDs) {
        self.useCase = useCase
    }
    
    public override func provide() -> String? {
        return useCase.getAffiseDeviseId()
    }
    
    public override func getOrder() -> Float {
        27.0
    }

    public override func getKey() -> ProviderType? {
        ProviderType.AFFISE_DEVICE_ID
    }
}
