import Foundation

/**
 * Provider for parameter [ProviderType.APP_VERSION]
 */
class AppVersionProvider: StringPropertyProvider {
    private let useCase: PackageInfoUseCase
    
    init(useCase: PackageInfoUseCase) {
        self.useCase = useCase
    }
    
    override func provide() -> String? {
        return useCase.getAppVersion()
    }
    
    public override func getOrder() -> Float {
        3.0
    }

    public override func getKey() -> ProviderType? {
        ProviderType.APP_VERSION
    }
}
