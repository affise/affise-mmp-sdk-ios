import Foundation

/**
 * Factory for [PostBackModelFactory]
 */
internal class PropertiesProviderFactory {
    
    private let vendorUseCase: VendorUseCase
    private let emulatorUseCase: EmulatorUseCase
    private let firstAppOpenUseCase: FirstAppOpenUseCase
    private let sessionManager: SessionManager
    private let preferences: UserDefaults
    private let initPropertiesStorage: InitPropertiesStorage
    //    private let stringToMd5Converter: Converter<String, String>
    //    private let stringToSha1Converter: Converter<String, String>
    private let stringToSha256Converter: StringToSHA256Converter
    private let logsManager: LogsManager
    private let deeplinkClickRepository: DeeplinkClickRepository
    private let retrieveReferrerUseCase: RetrieveReferrerUseCase
    private let pushTokenUseCase: PushTokenUseCase
    private let packageInfoUseCase: PackageInfoUseCase
    private let appUUIDs: AppUUIDs
    
    init(
        firstAppOpenUseCase: FirstAppOpenUseCase,
        vendorUseCase: VendorUseCase,
        emulatorUseCase: EmulatorUseCase,
        sessionManager: SessionManager,
        preferences: UserDefaults,
        initPropertiesStorage: InitPropertiesStorage,
        stringToSha256Converter: StringToSHA256Converter,
        logsManager: LogsManager,
        deeplinkClickRepository: DeeplinkClickRepository,
        retrieveReferrerUseCase: RetrieveReferrerUseCase,
        pushTokenUseCase: PushTokenUseCase,
        packageInfoUseCase: PackageInfoUseCase,
        appUUIDs: AppUUIDs
    ) {
        self.vendorUseCase = vendorUseCase
        self.emulatorUseCase = emulatorUseCase
        self.firstAppOpenUseCase = firstAppOpenUseCase
        self.sessionManager = sessionManager
        self.preferences = preferences
        self.initPropertiesStorage = initPropertiesStorage
        self.stringToSha256Converter = stringToSha256Converter
        self.logsManager = logsManager
        self.deeplinkClickRepository = deeplinkClickRepository
        self.retrieveReferrerUseCase = retrieveReferrerUseCase
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
                DeeplinkClickPropertyProvider(deeplinkClickRepository: deeplinkClickRepository),
                EmptyStringProvider(ProviderType.DEVICE_ATLAS_ID, order: 26.0),
                AffiseDeviceIdProvider(useCase: appUUIDs),
                AffiseAltDeviceIdProvider(useCase: appUUIDs),
                IdentifierForVendorProvider(useCase: vendorUseCase),
                IsEmulatorProvider(useCase: emulatorUseCase),
                RefTokenProvider(preferences: preferences),
                RefTokensProvider(preferences: preferences),
                PlatformNameProvider(),
                SdkPlatformNameProvider(),
                AffSDKVersionProvider(),
                RandomUserIdProvider(useCase: appUUIDs),
                IsProductionPropertyProvider(storage: initPropertiesStorage),
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
                ReferrerProvider(retrieveReferrerUseCase)
            ]
        )
    }
}
