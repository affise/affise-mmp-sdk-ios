import AffiseAttributionLib
import Foundation

/**
 * Provider for parameter [ProviderType.CPU_TYPE]
 */
class CpuTypeProvider: StringPropertyProvider {

    private let useCase: ProcessInfoUseCase

    init(useCase: ProcessInfoUseCase) {
        self.useCase = useCase
    }

    override func provide() -> String? {
        return useCase.getCpuName()
    }
    
    public override func getOrder() -> Float {
        22.0
    }

    public override func getKey() -> ProviderType? {
        ProviderType.CPU_TYPE
    }
}
