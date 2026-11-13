import AffiseAttributionLib
import Foundation

/**
 * Provider for parameter [ProviderType.TIMEZONE_DEV]
 */
class TimezoneDeviceProvider : StringPropertyProvider {
    /**
     * Returns timezone formatted in UTC template, for ex: UTC+0200
     */
    override func provide() -> String? {
        let formatter = DateFormatter()
        formatter.calendar = Calendar.current
        formatter.dateFormat = "XXXXX"
        return "UTC\(formatter.string(from: Date()))"
    }
    
    public override func getOrder() -> Float {
        51.0
    }

    public override func getKey() -> ProviderType? {
        ProviderType.TIMEZONE_DEV
    }
}
