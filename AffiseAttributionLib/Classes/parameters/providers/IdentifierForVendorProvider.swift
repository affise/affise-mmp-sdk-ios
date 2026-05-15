import Foundation

/**
 * Provider for parameter [ProviderType.IDFV]
 * IDFV (Identifier for Vendor)
 */
class IdentifierForVendorProvider: StringPropertyProvider {
    
    private let useCase: DeviceUseCase
    
    init(useCase: DeviceUseCase) {
        self.useCase = useCase
    }

    override func provide() -> String? {
        return useCase.getIdentifierForVendor()
    }
    
    public override func getOrder() -> Float {
        29.0
    }

    public override func getKey() -> ProviderType? {
        ProviderType.IDFV
    }
}
