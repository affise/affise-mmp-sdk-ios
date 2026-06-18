/**
 * Provider for parameter [ProviderType.DENSITY]
 */
class DensityProvider: FloatPropertyProvider {

    private let useCase: ScreenUseCase

    init(useCase: ScreenUseCase) {
        self.useCase = useCase
    }

    override func provide() -> Double? {
        return useCase.getDensity()
    }

    public override func getOrder() -> Float {
        22.4
    }

    public override func getKey() -> ProviderType? {
        ProviderType.DENSITY
    }
}
