import AffiseAttributionLib
import Foundation

/**
 * Provider for parameter [ProviderType.DEVICE_TYPE]
 */
class DeviceTypeProvider: StringPropertyProvider {
    
    private let useCase: DeviceUseCase
    
    init(useCase: DeviceUseCase) {
        self.useCase = useCase
    }

    override func provide() -> String? {
        return useCase.getDeviceType()
    }
    
    public override func getOrder() -> Float {
        42.0
    }

    public override func getKey() -> ProviderType? {
        ProviderType.DEVICE_TYPE
    }
}
