import Foundation

internal class ProcessInfoUseCaseImpl: ProcessInfoUseCase {

    func getCpuName() -> String {
        return CPUinfo()
    }

    func getCpuCores() -> Int64 {
        return Int64(ProcessInfo.processInfo.processorCount)
    }

    private func CPUinfo() -> String {
#if targetEnvironment(simulator)
        let identifier = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"]!
#else

        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 , value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
#endif
        return identifier
    }
}
