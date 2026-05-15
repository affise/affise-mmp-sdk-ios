import Foundation

/**
 * Provider for parameter [ProviderType.DEVICE_NAME]
 */
class DeviceNameProvider: StringPropertyProvider {
    
    private let useCase: DeviceUseCase
    
    init(useCase: DeviceUseCase) {
        self.useCase = useCase
    }

    override func provide() -> String? {
        return useCase.getDeviceName()
    }
    
    public override func getOrder() -> Float {
        41.0
    }

    public override func getKey() -> ProviderType? {
        ProviderType.DEVICE_NAME
    }
}
