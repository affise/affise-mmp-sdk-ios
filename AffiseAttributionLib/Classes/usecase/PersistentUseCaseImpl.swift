import Foundation

internal class PersistentUseCaseImpl : PersistentUseCase {

    private var moduleManager: AffiseModuleManager? = nil
    private var affDeviceId: String? = nil

    func initialize(moduleManager: AffiseModuleManager) {
        self.moduleManager = moduleManager
    }

    func getAffDeviceId() -> String? {
        if affDeviceId?.isBlank == false { return affDeviceId }
        affDeviceId = uuidFromPersistent() // ?? uuidFromAdvertisingId()
        return affDeviceId
    }

    private func getModule<T>(_ module: AffiseModules) -> T? {
        return moduleManager?.api(module) as? T
    }

    private func uuidFromPersistent() -> String?  {
        let persistentApi: AffisePersistentApi? = getModule(.Persistent)

        let affDevId: String? = persistentApi?.getOrCreate(AppUUIDsConstants.AFF_DEVICE_ID, generateUUID().uuidString.lowercased())

        if affDevId?.isBlank == true { return nil }
        return affDevId
    }

    // private func uuidFromAdvertisingId() -> String?  {
    //     let advertisingApi: AffiseAdvertisingApi? = getModule(module: .Advertising)

    //     // make fake UUID
    //     let advertisingId: String? = advertisingApi?.getAdvertisingId()

    //     if advertisingId?.isBlank == true { return nil }
    //     return advertisingId
    // }
}
