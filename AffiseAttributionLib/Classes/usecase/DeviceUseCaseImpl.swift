import Foundation
import UIKit


class DeviceUseCaseImpl {
    
    func emulatorCheck() -> Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }    
}

extension DeviceUseCaseImpl: DeviceUseCase {
    
    func isEmulator() -> Bool {
        return emulatorCheck()
    }

    /**
     * Get IDFV (Identifier for Vendor)
     */
    func getIdentifierForVendor() -> String? {
        guard let identifierForVendor = UIDevice.current.identifierForVendor else { return nil }
        return identifierForVendor.uuidString
    }

    
    func getSystemVersion() -> String {
        return UIDevice.current.systemVersion
    }

    
    func getDeviceName() -> String {
        return UIDevice.current.name
    }

    func getDeviceType() -> String {
        switch UIDevice.current.userInterfaceIdiom {
            
        case .unspecified:
            return "smartphone"
        case .phone:
            return "smartphone"
        case .pad:
            return "tablet"
        case .tv:
            return "tv"
        case .carPlay:
            return "car"
        case .mac:
            return "mac"
//        @unknown
        default:
            return "smartphone"
        } 
    }

    func getHardwareName() -> String {
        return UIDevice.current.model
    }
    
    func getOsName() -> String {
        return UIDevice.current.systemName
    }

    func getOsAndVersion() -> String {
        let uid: UIDevice = UIDevice.current
        return "\(uid.systemName) \(uid.systemVersion)"
    }
}
