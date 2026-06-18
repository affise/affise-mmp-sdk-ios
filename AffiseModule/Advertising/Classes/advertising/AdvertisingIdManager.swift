/**
 * Manager to track google advertising id changes
 */
protocol AdvertisingIdManager {
    /**
     * Called on  init
     */
    func initialize()

    /**
     * Returns google advertising id if present
     */
    func getAdvertisingId() -> String?

    func isAdvertiserTrackingEnabled() -> Bool

    func isApplicationTrackingEnabled() -> Bool
}
