import Foundation

@objc
public class AffiseAttributionModule :  NSObject,  AffiseAttributionModuleApi {
    
    private var api: AffiseApi? {
        get {
            Affise.api
        }
    }

    @objc
    public let Advertising: AffiseModuleAdvertisingApi = AffiseAdvertising()

    @objc
    public let AppsFlyer: AffiseModuleAppsFlyerApi = AffiseAppsFlyer()

    @objc
    public let Link: AffiseModuleLinkApi = AffiseLink()
    
    public let Subscription: AffiseModuleSubscriptionApi = AffiseSubscription()

    @objc
    public let TikTok: AffiseModuleTikTokApi = AffiseTikTok()

    /**
     * Get module status
     */
    @objc
    public func getStatus(_ module: AffiseModules, _ onComplete: @escaping OnKeyValueCallback) {
        api?.moduleManager.status(module, onComplete)
    }

    /**
     * Get installed modules
     */
    @objc
    public func getModulesInstalledObjc() -> [String] {
        return api?.moduleManager.getModulesNames().map { $0.description } ?? []
    }
    
    /**
     * Get installed modules
     */
    public func getModulesInstalled() -> [AffiseModules] {
        return api?.moduleManager.getModulesNames() ?? []
    }
}