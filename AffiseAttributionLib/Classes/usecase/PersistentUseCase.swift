import Foundation

internal protocol PersistentUseCase {
    func initialize(moduleManager: AffiseModuleManager)
    func getAffDeviceId() -> String?
}