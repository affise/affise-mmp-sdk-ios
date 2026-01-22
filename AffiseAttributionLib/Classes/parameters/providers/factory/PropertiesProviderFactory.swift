import Foundation
import UIKit

/**
 * Factory for [PostBackModelFactory]
 */
internal class PropertiesProviderFactory {
    
    private let firstAppOpenUseCase: FirstAppOpenUseCase
    private let webViewUseCase: WebViewUseCase
    private let sessionManager: SessionManager
    private let preferences: UserDefaults
    private let initPropertiesStorage: InitPropertiesStorage
    //    private let stringToMd5Converter: Converter<String, String>
    //    private let stringToSha1Converter: Converter<String, String>
    private let stringToSha256Converter: StringToSHA256Converter
    private let logsManager: LogsManager
    private let deeplinkClickRepository: DeeplinkClickRepository
    private let deviceUseCase: DeviceUseCase
    private let remarketingUseCase: RemarketingUseCase
    private let retrieveReferrerUseCase: RetrieveReferrerUseCase
    private let networkInfoUseCase: NetworkInfoUseCase
    private let pushTokenUseCase: PushTokenUseCase
    private let packageInfoUseCase: PackageInfoUseCase
    private let appUUIDs: AppUUIDs
    
    init(
        firstAppOpenUseCase: FirstAppOpenUseCase,
        webViewUseCase: WebViewUseCase,
        sessionManager: SessionManager,
        preferences: UserDefaults,
        initPropertiesStorage: InitPropertiesStorage,
        stringToSha256Converter: StringToSHA256Converter,
        logsManager: LogsManager,
        deeplinkClickRepository: DeeplinkClickRepository,
        deviceUseCase: DeviceUseCase,
        remarketingUseCase: RemarketingUseCase,
        retrieveReferrerUseCase: RetrieveReferrerUseCase,
        networkInfoUseCase: NetworkInfoUseCase,
        pushTokenUseCase: PushTokenUseCase,
        packageInfoUseCase: PackageInfoUseCase,
        appUUIDs: AppUUIDs
    ) {
        self.firstAppOpenUseCase = firstAppOpenUseCase
        self.webViewUseCase = webViewUseCase
        self.sessionManager = sessionManager
        self.preferences = preferences
        self.initPropertiesStorage = initPropertiesStorage
        self.stringToSha256Converter = stringToSha256Converter
        self.logsManager = logsManager
        self.deeplinkClickRepository = deeplinkClickRepository
        self.deviceUseCase = deviceUseCase
        self.remarketingUseCase = remarketingUseCase
        self.retrieveReferrerUseCase = retrieveReferrerUseCase
        self.networkInfoUseCase = networkInfoUseCase
        self.pushTokenUseCase = pushTokenUseCase
        self.packageInfoUseCase = packageInfoUseCase
        self.appUUIDs = appUUIDs
    }
    
    func create() -> PostBackModelFactory {
        
        let firstOpenTimeProvider = FirstOpenTimeProvider(useCase: firstAppOpenUseCase)
        let lastSessionTimeProvider = LastSessionTimeProvider(sessionManager: sessionManager)

        return PostBackModelFactory(
            providers: [
                UuidProvider(),
                AffiseAppIdProvider(storage: initPropertiesStorage),
                AffisePackageAppNameProvider(useCase: packageInfoUseCase),
                AppVersionProvider(useCase: packageInfoUseCase),
                AppVersionRawProvider(useCase: packageInfoUseCase),
                StoreProvider(),
                InstalledTimeProvider(useCase: firstAppOpenUseCase),
                firstOpenTimeProvider,
                InstalledHourProvider(useCase: firstAppOpenUseCase),
                FirstOpenHourProvider(useCase: firstAppOpenUseCase),
                InstallFirstEventProvider(useCase: firstAppOpenUseCase),
                InstallBeginTimeProvider(useCase: firstAppOpenUseCase),
                InstallFinishTimeProvider(useCase: firstAppOpenUseCase),
                CreatedTimeProvider(),
                CreatedTimeMilliProvider(),
                CreatedTimeHourProvider(),
                CustomLongProvider(ProviderType.LAST_TIME_SESSION, order: 54.0) {
                    return lastSessionTimeProvider.provide()
                },
                ConnectionTypeProvider(),
                CpuTypeProvider(),
                HardwareNameProvider(),
                NetworkTypeProvider(),
                DeviceManufacturerProvider(),
                ProxyIpAddressProvider(),
                DeeplinkClickPropertyProvider(deeplinkClickRepository: deeplinkClickRepository),
                EmptyStringProvider(ProviderType.DEVICE_ATLAS_ID, order: 26.0),
                AffiseDeviceIdProvider(useCase: appUUIDs),
                AffiseAltDeviceIdProvider(useCase: appUUIDs),
                RefTokenProvider(preferences: preferences),
                RefTokensProvider(preferences: preferences),
                UserAgentProvider(useCase: webViewUseCase),
                MCCProvider(useCase: networkInfoUseCase),
                MNCProvider(useCase: networkInfoUseCase),
                IspNameProvider(useCase: networkInfoUseCase),
                IsEmulatorProvider(useCase: deviceUseCase),
                RegionProvider(),
                CountryProvider(),
                LanguageProvider(remarketingUseCase),
                DeviceNameProvider(),
                DeviceTypeProvider(),
                OsNameProvider(),
                PlatformNameProvider(),
                SdkPlatformNameProvider(),
                AffSDKVersionProvider(),
                OSVersionProvider(),
                RandomUserIdProvider(useCase: appUUIDs),
                IsProductionPropertyProvider(storage: initPropertiesStorage),
                TimezoneDeviceProvider(),
                EmptyStringProvider(ProviderType.AFFISE_EVENT_TOKEN, order: 52.0),
                EmptyStringProvider(ProviderType.AFFISE_EVENT_NAME, order: 53.0),
                lastSessionTimeProvider,
                TimeSessionProvider(sessionManager: sessionManager),
                AffiseSessionCountProvider(sessionManager: sessionManager),
                LifetimeSessionCountProvider(sessionManager: sessionManager),
                DeeplinkProvider(deeplinkClickRepository: deeplinkClickRepository),
                AffPartParamNamePropertyProvider(storage: initPropertiesStorage),
                AffPartParamNameTokenPropertyProvider(storage: initPropertiesStorage),
                AffAppTokenPropertyProvider(storage: initPropertiesStorage, stringToSHA256Converter: stringToSha256Converter),
                // AffSDKSecretIdProvider(storage: initPropertiesStorage),
                EmptyStringProvider(ProviderType.LABEL, order: 62.0),
                PushTokenProvider(pushTokenUseCase),
                PushTokenServiceProvider(pushTokenUseCase),
                OsAndVersionProvider(remarketingUseCase),
                DeviceProvider(remarketingUseCase),
                BuildProvider(remarketingUseCase),
                ReferrerProvider(retrieveReferrerUseCase)
            ]
        )
    }
}
