import Foundation

/**
 * Provider for parameter [ProviderType.OS_NAME]
 */
class OsNameProvider: StringPropertyProvider {
    
    private let useCase: DeviceUseCase
    
    init(useCase: DeviceUseCase) {
        self.useCase = useCase
    }

    override func provide() -> String? {
        return useCase.getOsName()
    }
    
    public override func getOrder() -> Float {
        43.0
    }

    public override func getKey() -> ProviderType? {
        ProviderType.OS_NAME
    }
}
