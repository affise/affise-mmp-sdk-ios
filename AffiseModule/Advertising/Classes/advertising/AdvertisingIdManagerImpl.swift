import AdSupport
import AppTrackingTransparency


class AdvertisingIdManagerImpl : AdvertisingIdManager {
    
    private lazy var asIdentifierManager: ASIdentifierManager = ASIdentifierManager.shared() 
    
    var advertisingId: String?
    
    func initialize() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { [weak self] status in
                guard let self = self else {
                    return
                }
                if status == .authorized {
                    let adId = self.asIdentifierManager.advertisingIdentifier
                    self.advertisingId = adId.uuidString
                }
            }
        } else if asIdentifierManager.isAdvertisingTrackingEnabled {
            let adId = self.asIdentifierManager.advertisingIdentifier
            self.advertisingId = adId.uuidString
        }
    }
    
    func getAdvertisingId() -> String? {
        return advertisingId
    }

    func isAdvertiserTrackingEnabled() -> Bool {
        if #available(iOS 14, *) {
            return ATTrackingManager.trackingAuthorizationStatus == .authorized
        }

        return asIdentifierManager.isAdvertisingTrackingEnabled
    }

    func isApplicationTrackingEnabled() -> Bool {
        return asIdentifierManager.isAdvertisingTrackingEnabled
    }
}
