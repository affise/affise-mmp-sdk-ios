import Foundation

protocol DeviceUseCase {


    func getSystemVersion() -> String

    func getDeviceName() -> String

    func getDeviceType() -> String

    func getHardwareName() -> String

    func getOsName() -> String

    func getOsAndVersion() -> String
}
