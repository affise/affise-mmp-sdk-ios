/**
 * Provider for parameter [ProviderType.TOTAL_DISK]
 */
class TotalDiskProvider: LongPropertyProvider {

    private let useCase: DiskUseCase

    init(useCase: DiskUseCase) {
        self.useCase = useCase
    }

    override func provide() -> Int64? {
        return useCase.getTotalDisk()
    }

    public override func getOrder() -> Float {
        22.5
    }

    public override func getKey() -> ProviderType? {
        ProviderType.TOTAL_DISK
    }
}
