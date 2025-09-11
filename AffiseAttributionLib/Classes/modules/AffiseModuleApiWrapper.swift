import Foundation

internal protocol AffiseModuleApiWrapper: AnyObject {
    associatedtype API
    var api: API? { get set }
    var module: AffiseModules { get }
}

extension AffiseModuleApiWrapper {
    
    internal var moduleManager: AffiseModuleManager? {
        get { Affise.api?.moduleManager }
    }
    
    internal var moduleApi: API? {
        get {
            if api == nil {
                api = moduleManager?.api(module) as? API
            }
            return api
        }
    }
    
    internal var hasModule: Bool {
        get {
            return Affise.api?.moduleManager.hasModule(module) ?? false
        }
    }
}
