import Foundation
import UIKit

internal class RemarketingUseCaseImpl: RemarketingUseCase {
    
    lazy var osAndVersion: String = getOsAndVersion()
    
    lazy var device: String? = getDevice()
    
    lazy var build: String? = getBuild()
    
    func local() -> String {
        let locale = Locale.current
        guard let languageCode = locale.languageCode else { return locale.identifier }
        guard let regionCode = locale.regionCode else { return locale.identifier }
        return "\(languageCode)_\(regionCode)"
    }

    private func getOsAndVersion() -> String {
        let uid:UIDevice = UIDevice.current
        return "\(uid.systemName) \(uid.systemVersion)"
    }

    private func getDevice() -> String? {
        return SysctlKey("hw.machine")
    }

    private func getBuild() -> String? {
        if let build = SysctlKey("kern.osversion") {
            return "Build/\(build)"
        }
        return nil
    }
    
    private func SysctlKey(_ key: String) -> String? {
        var bufferSize = 0
        sysctlbyname(key, nil, &bufferSize, nil, 0)
        var buffer = [CChar](repeating: 0, count: Int(bufferSize))
        let status = sysctlbyname(key, &buffer, &bufferSize, nil, 0)
        if status != 0 {
            return nil
        }
        return String(cString:buffer, encoding: String.Encoding.utf8)
    }
}
