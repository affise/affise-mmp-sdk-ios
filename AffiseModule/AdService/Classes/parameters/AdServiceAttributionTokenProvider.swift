import AffiseAttributionLib

/**
 * Provider for parameter [ProviderType.AD_SERVICE_ATTRIBUTION]
 */
internal class AdServiceAttributionTokenProvider : StringPropertyProvider {
    
    private let useCase: AdServiceUseCase
    
    init(adServiceUseCase: AdServiceUseCase) {
        self.useCase = adServiceUseCase
    }

    public override func provide() -> String? {
        return useCase.getAttributionToken()
    }
    
    public override func getOrder() -> Float {
        29.2
    }

    public override func getKey() -> ProviderType? {
        ProviderType.AD_SERVICE_ATTRIBUTION
    }
}
