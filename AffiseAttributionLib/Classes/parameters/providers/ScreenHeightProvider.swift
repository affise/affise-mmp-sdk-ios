/**
 * Provider for parameter [ProviderType.SCREEN_HEIGHT]
 */
class ScreenHeightProvider: LongPropertyProvider {

    private let useCase: ScreenUseCase

    init(useCase: ScreenUseCase) {
        self.useCase = useCase
    }

    override func provide() -> Int64? {
        return useCase.getScreenHeight()
    }

    public override func getOrder() -> Float {
        22.3
    }

    public override func getKey() -> ProviderType? {
        ProviderType.SCREEN_HEIGHT
    }
}
