import Foundation

/**
 * Provider for parameter [ProviderType.HARDWARE_NAME]
 */
class HardwareNameProvider: StringPropertyProvider {
    
    private let useCase: DeviceUseCase
    
    init(useCase: DeviceUseCase) {
        self.useCase = useCase
    }

    override func provide() -> String? {
        return useCase.getHardwareName()
    }
    
    public override func getOrder() -> Float {
        23.0
    }

    public override func getKey() -> ProviderType? {
        ProviderType.HARDWARE_NAME
    }
}
