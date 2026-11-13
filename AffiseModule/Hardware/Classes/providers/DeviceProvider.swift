import AffiseAttributionLib
import Foundation

/**
 * Provider for parameter [ProviderType.DEVICE]
 */
class DeviceProvider: StringPropertyProvider {
    
    private let useCase: RemarketingUseCase
    
    init(_ useCase: RemarketingUseCase) {
        self.useCase = useCase
    }

    override func provide() -> String? {
        useCase.device
    }
    
    public override func getOrder() -> Float {
        69.0
    }

    public override func getKey() -> ProviderType? {
        ProviderType.DEVICE
    }
}
