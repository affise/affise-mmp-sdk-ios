/**
 * Provider for parameter [ProviderType.SCREEN_WIDTH]
 */
class ScreenWidthProvider: LongPropertyProvider {

    private let useCase: ScreenUseCase

    init(useCase: ScreenUseCase) {
        self.useCase = useCase
    }

    override func provide() -> Int64? {
        return useCase.getScreenWidth()
    }

    public override func getOrder() -> Float {
        22.2
    }

    public override func getKey() -> ProviderType? {
        ProviderType.SCREEN_WIDTH
    }
}
