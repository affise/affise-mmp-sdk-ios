import AffiseAttributionLib
import Foundation

/**
 * Provider for parameter [ProviderType.BUILD]
 */
class BuildProvider: StringPropertyProvider {
    
    private let useCase: RemarketingUseCase
    
    init(_ useCase: RemarketingUseCase) {
        self.useCase = useCase
    }

    override func provide() -> String? {
        useCase.build
    }
    
    public override func getOrder() -> Float {
        70.0
    }

    public override func getKey() -> ProviderType? {
        ProviderType.BUILD
    }
}
