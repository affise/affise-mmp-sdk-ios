import Foundation


@objc
public protocol AffiseAdvertisingApi: AffiseModuleApi {
    func startModule()
    func getAdvertisingId() -> String?
}
