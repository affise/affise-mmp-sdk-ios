import Foundation

internal class AffiseAdvertising : NSObject, AffiseModuleApiWrapper {
    typealias API = AffiseAdvertisingApi
    var api: API?
    var module: AffiseModules = .Advertising
}

extension AffiseAdvertising : AffiseModuleAdvertisingApi {
    
    func hasModule() -> Bool { hasModule }
    
    func startModule() {
        moduleApi?.startModule()
        moduleManager?.updateProviders(module)
    }
    
    func getAdvertisingId() -> String? {
        return moduleApi?.getAdvertisingId()
    }
}
