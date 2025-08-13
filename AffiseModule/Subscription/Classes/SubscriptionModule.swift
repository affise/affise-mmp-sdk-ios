import Foundation
import AffiseAttributionLib


@objc(AffiseSubscriptionModule)
public final class SubscriptionModule: AffiseModule, AffiseSubscriptionApi {
    
    public override var version: String { BuildConfig.AFFISE_VERSION }
    
    lazy var storeManager: StoreManager = StoreManager()

    override public func start() {
    }
    
    public func fetchProducts(_ productsIds: [String], _ callback: @escaping AffiseResultCallback<AffiseProductsResult>) {
        storeManager.fetchProducts(productsIds, callback)
    }
    
    public func purchase(_ product: AffiseProduct, _ type: AffiseProductType? = nil, _ callback: @escaping AffiseResultCallback<AffisePurchasedInfo>) {
        storeManager.purchase(product, type, callback)
    }
}
