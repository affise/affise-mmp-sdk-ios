import Foundation

@objc
public protocol AffiseAttributionModuleApi : AnyObject {
    /**
     * Get module status
     */
    func getStatus(_ module: AffiseModules, _ onComplete: @escaping OnKeyValueCallback)

    /**
     * Get installed modules
     */
    func getModulesInstalledObjc() -> [String]
}
