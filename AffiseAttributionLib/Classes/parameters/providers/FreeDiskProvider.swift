/**
 * Provider for parameter [ProviderType.FREE_DISK]
 */
class FreeDiskProvider: LongPropertyProvider {

    private let useCase: DiskUseCase

    init(useCase: DiskUseCase) {
        self.useCase = useCase
    }

    override func provide() -> Int64? {
        return useCase.getFreeDisk()
    }

    public override func getOrder() -> Float {
        22.6
    }

    public override func getKey() -> ProviderType? {
        ProviderType.FREE_DISK
    }
}
