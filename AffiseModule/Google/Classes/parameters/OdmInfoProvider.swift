import AffiseAttributionLib

/**
 * Provider for parameter [ProviderType.ODM_INFO]
 */
internal class OdmInfoProvider: StringPropertyProvider {

    private let useCase: GoogleOdmUseCase

    init(googleOdmUseCase: GoogleOdmUseCase) {
        self.useCase = googleOdmUseCase
    }

    public override func provide() -> String? {
        useCase.getOdmInfo()
    }

    public override func getOrder() -> Float {
        29.3
    }

    public override func getKey() -> ProviderType? {
        ProviderType.ODM_INFO
    }
}
