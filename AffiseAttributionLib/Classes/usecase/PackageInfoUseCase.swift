import Foundation

internal protocol PackageInfoUseCase {
    func getFirstInstallTime() -> TimeInterval?
    func getPackageAppName() -> String?
    func getAppVersion() -> String?
    func getAppVersionRaw() -> String?
}
