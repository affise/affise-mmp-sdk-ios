import AffiseAttributionLib
import Foundation

/**
 * Provider for parameter [ProviderType.LANGUAGE]
 */
class LanguageProvider: StringPropertyProvider {
    
    private let useCase: RemarketingUseCase
    
    init(_ useCase: RemarketingUseCase) {
        self.useCase = useCase
    }
    
    override func provide() -> String? {
        useCase.local()
    }
    
    public override func getOrder() -> Float {
        40.0
    }

    public override func getKey() -> ProviderType? {
        ProviderType.LANGUAGE
    }
}
