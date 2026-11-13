import AffiseAttributionLib
/**
 * Provider for parameter [ProviderType.USER_AGENT]
 */
internal class UserAgentProvider : StringPropertyProvider {
    private let useCase: WebViewUseCase
    
    init(useCase: WebViewUseCase) {
        self.useCase = useCase
    }

    override func provide() -> String? {
        return useCase.getUserAgent()
    }
    
    public override func getOrder() -> Float {
        35.0
    }

    public override func getKey() -> ProviderType? {
        ProviderType.USER_AGENT
    }
}
