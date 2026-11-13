import AffiseAttributionLib
import Foundation

/**
 * Provider for parameter [ProviderType.REGION]
 */
class RegionProvider: StringPropertyProvider {
    
    override func provide() -> String? {
        return Locale.current.regionCode
    }
    
    public override func getOrder() -> Float {
        38.0
    }

    public override func getKey() -> ProviderType? {
        ProviderType.REGION
    }
}
