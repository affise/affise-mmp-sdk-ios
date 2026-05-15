import Foundation

/**
 * Provider for parameter [ProviderType.OS_VERSION]
 */
class OSVersionProvider: StringPropertyProvider {
        
    private let useCase: DeviceUseCase
    
    init(useCase: DeviceUseCase) {
        self.useCase = useCase
    }

    override func provide() -> String? {
        return useCase.getSystemVersion()
    }
    
    public override func getOrder() -> Float {
        48.0
    }

    public override func getKey() -> ProviderType? {
        ProviderType.OS_VERSION
    }
}
