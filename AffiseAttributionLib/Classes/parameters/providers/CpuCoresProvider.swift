/**
 * Provider for parameter [ProviderType.CPU_CORES]
 */
class CpuCoresProvider: LongPropertyProvider {

    private let useCase: ProcessInfoUseCase

    init(useCase: ProcessInfoUseCase) {
        self.useCase = useCase
    }

    override func provide() -> Int64? {
        return useCase.getCpuCores()
    }

    public override func getOrder() -> Float {
        22.1
    }

    public override func getKey() -> ProviderType? {
        ProviderType.CPU_CORES
    }
}
