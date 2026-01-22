import Foundation


internal protocol AppUUIDs {
    /**
     * Get devise id
     * @return devise id
     */
    func getAffiseDeviseId() -> String?

    /**
     * Get alt devise id
     * @return alt devise id
     */
    func getAffiseAltDeviseId() -> String?

    /**
     * Get random user id
     * @return random user id
     */
    func getRandomUserId() -> String?
}

internal struct AppUUIDsConstants {
    static let AFF_DEVICE_ID = "AFF_DEVICE_ID"
    static let AFF_ALT_DEVICE_ID = "AFF_ALT_DEVICE_ID"
    static let RANDOM_USER_ID = "random_user_id"
}
