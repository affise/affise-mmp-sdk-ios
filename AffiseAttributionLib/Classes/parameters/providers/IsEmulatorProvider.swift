/**
 * Provider for parameter [ProviderType.IS_EMULATOR]
 */
class IsEmulatorProvider: BooleanPropertyProvider {
    
    private let useCase: EmulatorUseCase
    
    init(useCase: EmulatorUseCase) {
        self.useCase = useCase
    }

    override func provide() -> Bool? {
        return useCase.isEmulator()
    }
    
    public override func getOrder() -> Float {
        67.0
    }

    public override func getKey() -> ProviderType? {
        ProviderType.IS_EMULATOR
    }
}
