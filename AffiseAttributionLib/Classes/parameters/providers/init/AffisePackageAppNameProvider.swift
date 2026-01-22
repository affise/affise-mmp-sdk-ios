import Foundation

/**
 * Provider for parameter [ProviderType.AFFISE_PKG_APP_NAME]
 *
 */
public class AffisePackageAppNameProvider: StringPropertyProvider {
    private let useCase: PackageInfoUseCase
    
    init(useCase: PackageInfoUseCase) {
        self.useCase = useCase
    }
    
    public override func provide() -> String? {
        return useCase.getPackageAppName()
    }
    
    public override func getOrder() -> Float {
        2.0
    }

    public override func getKey() -> ProviderType? {
        ProviderType.AFFISE_PKG_APP_NAME
    }
}
