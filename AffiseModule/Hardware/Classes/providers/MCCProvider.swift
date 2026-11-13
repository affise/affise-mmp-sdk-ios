import AffiseAttributionLib
import CoreTelephony


/**
 * Provider for parameter [ProviderType.MCCODE]
 */
class MCCProvider: StringPropertyProvider {
    
    private let useCase: NetworkInfoUseCase
    
    init(useCase: NetworkInfoUseCase) {
        self.useCase = useCase
    }

    override func provide() -> String? {
        let carrier = useCase.firstCarrier()

        // Get carrier name
        let carrierName = carrier?.mobileCountryCode
        return carrierName
    }
    
    public override func getOrder() -> Float {
        36.0
    }

    public override func getKey() -> ProviderType? {
        ProviderType.MCCODE
    }
}
