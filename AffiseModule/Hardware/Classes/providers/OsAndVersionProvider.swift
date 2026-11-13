import AffiseAttributionLib
import Foundation

/**
 * Provider for parameter [ProviderType.OS_AND_VERSION]
 */
class OsAndVersionProvider: StringPropertyProvider {
    
    private let useCase: RemarketingUseCase
    
    init(_ useCase: RemarketingUseCase) {
        self.useCase = useCase
    }

    override func provide() -> String? {
        useCase.osAndVersion
    }
    
    public override func getOrder() -> Float {
        68.0
    }

    public override func getKey() -> ProviderType? {
        ProviderType.OS_AND_VERSION
    }
}
