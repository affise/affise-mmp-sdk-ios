import AffiseAttributionLib
import Foundation

/**
 * Provider for parameter [ProviderType.COUNTRY]
 */
class CountryProvider: StringPropertyProvider {
    
    override func provide() -> String? {
        return Locale.current.regionCode
    }
    
    public override func getOrder() -> Float {
        39.0
    }

    public override func getKey() -> ProviderType? {
        ProviderType.COUNTRY
    }
}
