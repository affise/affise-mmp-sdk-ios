import Foundation

/**
 * App version number (Android) [ProviderType.APP_VERSION_RAW]
 */
class AppVersionRawProvider: StringPropertyProvider {
    private let useCase: PackageInfoUseCase
    
    init(useCase: PackageInfoUseCase) {
        self.useCase = useCase
    }
    
    override func provide() -> String? {
        return useCase.getAppVersionRaw()
    }
    
    public override func getOrder() -> Float {
        4.0
    }

    public override func getKey() -> ProviderType? {
        ProviderType.APP_VERSION_RAW
    }
}
