import Foundation

@objc
public class AffiseAttributionModule :  NSObject,  AffiseAttributionModuleApi {
    
    private var api: AffiseApi? {
        get {
            Affise.api
        }
    }

    @objc
    public let AppsFlyer: AffiseModuleAppsFlyerApi = AffiseAppsFlyer()

    @objc
    public let Link: AffiseModuleLinkApi = AffiseLink()
    
    public let Subscription: AffiseModuleSubscriptionApi = AffiseSubscription()

    /**
     * Get module status
     */
    @objc
    public func getStatus(_ module: AffiseModules, _ onComplete: @escaping OnKeyValueCallback) {
        api?.moduleManager.status(module, onComplete)
    }
    
    /**
     * Manual module start
     */
    @objc
    @discardableResult
    public func moduleStart(_ module: AffiseModules) -> Bool {
        return api?.moduleManager.manualStart(module) ?? false
    }

    /**
     * Get installed modules
     */
    @objc
    public func getModulesInstalledObjc() -> [String] {
        return api?.moduleManager.getModules().map { $0.description } ?? []
    }
    
    /**
     * Get installed modules
     */
    public func getModulesInstalled() -> [AffiseModules] {
        return api?.moduleManager.getModules() ?? []
    }
}


extension AffiseAttributionModule {
    
    @available(*, deprecated, message: "Method moved to Affise.Module.Link", renamed: "Link.resolve")
    @objc
    public func linkResolve(_ url: String, _ callback: @escaping AffiseLinkCallback) {
        Affise.Module.Link.resolve(url, callback)
    }
    
    @available(*, deprecated, message: "Method moved to Affise.Module.Subscription", renamed: "Subscription.hasModule")
    public func hasSubscriptionModule() -> Bool {
        return Affise.Module.Subscription.hasModule()
    }
    
    @available(*, deprecated, message: "Method moved to Affise.Module.Subscription", renamed: "Subscription.fetchProducts")
    public func fetchProducts(_ productsIds: [String], _ callback: @escaping AffiseResultCallback<AffiseProductsResult>) {
        Affise.Module.Subscription.fetchProducts(productsIds, callback)
    }
    
    @available(*, deprecated, message: "Method moved to Affise.Module.Subscription", renamed: "Subscription.purchase")
    public func purchase(_ product: AffiseProduct, _ type: AffiseProductType?, _ callback: @escaping AffiseResultCallback<AffisePurchasedInfo>) {
        Affise.Module.Subscription.purchase(product, type, callback)
    }
}
