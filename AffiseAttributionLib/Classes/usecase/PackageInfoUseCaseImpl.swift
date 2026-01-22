import Foundation

internal class PackageInfoUseCaseImpl : PackageInfoUseCase {

    private let firstAppOpenUseCase: FirstAppOpenUseCase
    private let bundle: Bundle

    init(
        bundle: Bundle, 
        firstAppOpenUseCase: FirstAppOpenUseCase
    ) {
        self.bundle = bundle
        self.firstAppOpenUseCase = firstAppOpenUseCase
    }

    func getFirstInstallTime() -> TimeInterval? {
        return firstAppOpenUseCase.getFirstOpenDate()
    }
    
    func getPackageAppName() -> String? {
        return bundle.bundleIdentifier
    }

    func getAppVersion() -> String? {
        return bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }

    func getAppVersionRaw() -> String? {
        return bundle.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }
}
