import Foundation

protocol DeviceUseCase {
    func isEmulator() -> Bool

    /**
     * Get IDFV (Identifier for Vendor)
     */
    func getIdentifierForVendor() -> String?

    func getSystemVersion() -> String

    func getDeviceName() -> String

    func getDeviceType() -> String

    func getHardwareName() -> String

    func getOsName() -> String

    func getOsAndVersion() -> String
}
