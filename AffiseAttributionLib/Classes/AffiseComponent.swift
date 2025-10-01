import Foundation
import UIKit


internal class AffiseComponent: AffiseApi {
    
    private let app: UIApplication
    let initProperties: AffiseInitProperties
    private let launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    private var isReady: Bool = false

    init(
        app: UIApplication,
        initProperties: AffiseInitProperties,
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) {
        do {
            self.app = app;
            self.initProperties = initProperties;
            self.launchOptions = launchOptions;

    //        sendGDPREventUseCase.sendForgetMeEvent()
            webViewUseCase.initialize()
            setPropertiesWhenInitUseCase.initialize(initProperties: initProperties)
            sessionManager.initialize()
    //        oaidManager.init(app)
    //        retrieveInstallReferrerUseCase.startInstallReferrerRetrieve()
            deeplinkManager.initialize(launchOptions: launchOptions)
    //        autoCatchingClickProvider.init(initProperties.autoCatchingClickEvents)
    //        metricsManager.setEnabledMetrics(initProperties.enabledMetrics)

            moduleManager.initialize(
                app: app,
                dependencies: [
                    stringToSha256Converter,
                    networkService,
                    providersToJsonStringConverter,
                    postBackModelFactory,
                    postBackModelToJsonStringConverter
                ]
            )
            firstAppOpenUseCase.initialize(moduleManager: moduleManager)
            firstAppOpenUseCase.onAppCreated()
            try eventsManager.initialize()

            isReady = true
            initProperties.onInitSuccessHandler?()
        } catch {
            initProperties.onInitErrorHandler?(error)
        }
    }

    func isInitialized() -> Bool {
        return isReady
    }
    
    lazy var bundle: Bundle = Bundle.main
    lazy var preferences: UserDefaults = UserDefaults.standard
    lazy var urlSession: URLSession = URLSession.shared
    lazy var fileManager: FileManager = FileManager.default
    lazy var notificationCenter: NotificationCenter = NotificationCenter.default

    lazy var firstAppOpenUseCase:FirstAppOpenUseCase = FirstAppOpenUseCase(preferences: preferences)
    lazy var webViewUseCase:WebViewUseCase = WebViewUseCase(preferences: preferences)
    lazy var appLifecycleEventsManager:AppLifecycleEventsManager = AppLifecycleEventsManagerImpl(
        notificationCenter: notificationCenter,
        logsManager: logsManager
    )
    lazy var logsManager:LogsManager = LogsManagerImpl(storeLogsUseCase: storeLogsUseCase)
    lazy var logsRepository:LogsRepository = LogsRepositoryImpl(
        converterToBase64: ConverterToBase64(),
        converterToSerializedLog: LogToSerializedLogConverter(),
        logsStorage: logsStorage
    )
    lazy var logsStorage:LogsStorage = LogsStorageImpl(fileManager: fileManager)
    
    lazy var eventsManager:EventsManager = EventsManager(
        sendDataToServerUseCase: sendDataToServerUseCase,
        appLifecycleEventsManager: appLifecycleEventsManager
    )
    lazy var indexUseCase:IndexUseCase = IndexUseCaseImpl(
        preferences: preferences
    )
    lazy var eventsStorage:EventsStorage = EventsStorageImpl(logsManager: logsManager, fileManager: fileManager)
    lazy var eventToSerializedEventConverter:EventToSerializedEventConverter = EventToSerializedEventConverter(indexUseCase: indexUseCase)
    lazy var eventsRepository:EventsRepository = EventsRepositoryImpl(
        converterToBase64: ConverterToBase64(),
        converterToSerializedEvent: eventToSerializedEventConverter,
        logsManager: logsManager,
        eventsStorage: eventsStorage
    )
    lazy var internalEventsStorage:InternalEventsStorage = InternalEventsStorageImpl(
        logsManager: logsManager,
        fileManager: fileManager
    )
    lazy var internalEventsRepository:InternalEventsRepository = InternalEventsRepositoryImpl(
        converterToBase64: ConverterToBase64(),
        converterToSerializedEvent: InternalEventToSerializedEventConverter(),
        logsManager: logsManager,
        eventsStorage: internalEventsStorage
    )
    lazy var networkService:NetworkService = NetworkServiceImpl(urlSession: urlSession)
    lazy var postBackModelToJsonStringConverter:PostBackModelToJsonStringConverter = PostBackModelToJsonStringConverter(indexUseCase: indexUseCase)
    lazy var cloudRepository:CloudRepository = CloudRepositoryImpl(
        networkService: networkService,
        userAgentProvider: postBackModelFactory.getProvider(),
        converter: postBackModelToJsonStringConverter
    )
    lazy var sessionManager:SessionManager = SessionManagerImpl(
        preferences: preferences,
        appLifecycleEventsManager: appLifecycleEventsManager
    )
    lazy var storeEventUseCase:StoreEventUseCase = StoreEventUseCaseImpl(
        repository: eventsRepository,
        eventsManager: eventsManager,
        preferencesUseCase: preferencesUseCase,
        appLifecycleEventsManager: appLifecycleEventsManager,
        logsManager: logsManager,
        isFirstForUserUseCase: isFirstForUserUseCase
    )
    lazy var storeInternalEventUseCase: StoreInternalEventUseCase = StoreInternalEventUseCaseImpl(repository: internalEventsRepository)
    lazy var storeLogsUseCase: StoreLogsUseCase = StoreLogsUseCaseImpl(repository: logsRepository)
    lazy var isFirstForUserStorage: IsFirstForUserStorage = IsFirstForUserStorageImpl(logsManager: logsManager, fileManager: fileManager)
    lazy var isFirstForUserUseCase: IsFirstForUserUseCase = IsFirstForUserUseCaseImpl(isFirstForUserStorage: isFirstForUserStorage)
    lazy var initPropertiesStorage: InitPropertiesStorage = InitPropertiesStorageImpl()
    lazy var setPropertiesWhenInitUseCase: SetPropertiesWhenAppInitializedUseCase = SetPropertiesWhenAppInitializedUseCaseImpl(
        storage: initPropertiesStorage
    )
    lazy var sendDataToServerUseCase: SendDataToServerUseCase = SendDataToServerUseCaseImpl(
        postBackModelFactory: postBackModelFactory,
        cloudRepository: cloudRepository,
        eventsRepository: eventsRepository,
        internalEventsRepository: internalEventsRepository,
        logsRepository: logsRepository,
        logsManager: logsManager,
        preferencesUseCase: preferencesUseCase,
        firstAppOpenUseCase: firstAppOpenUseCase
    )
    lazy var immediateSendToServerUseCase: ImmediateSendToServerUseCase = ImmediateSendToServerUseCaseImpl(
        cloudRepository: cloudRepository,
        postBackModelFactory: postBackModelFactory,
        converterToSerializedEvent: eventToSerializedEventConverter,
        logsManager: logsManager
    )
    lazy var pushTokenUseCase: PushTokenUseCase = PushTokenUseCaseImpl(
        preferences: preferences
    )
    lazy var deeplinkClickRepository: DeeplinkClickRepository = DeeplinkClickRepositoryImpl()
    lazy var deeplinkManager: DeeplinkManager = DeeplinkManagerImpl(
        isDeeplinkRepository: deeplinkClickRepository,
        appLifecycleEventsManager: appLifecycleEventsManager
    )
    lazy var webBridgeManager: WebBridgeManager = WebBridgeManager(storeEventUseCase: storeEventUseCase)
    lazy var preferencesUseCase: PreferencesUseCase = PreferencesUseCaseImpl(
        repository: ApplicationLifecyclePreferencesRepositoryImpl(),
        lifetimeRepository: ApplicationLifetimePreferencesRepositoryImpl(userDefaults: preferences)
    )

    lazy var stringToSha256Converter: StringToSHA256Converter = StringToSHA256Converter()
    lazy var providersToJsonStringConverter: ProvidersToJsonStringConverter = ProvidersToJsonStringConverter()
    lazy var deviceUseCase: DeviceUseCase = DeviceUseCaseImpl()
    lazy var remarketingUseCase: RemarketingUseCase = RemarketingUseCaseImpl()
    lazy var networkInfoUseCase: NetworkInfoUseCase = NetworkInfoUseCaseImpl()

    /**
     * PostBackModelFactory
     */
    lazy var postBackModelFactory: PostBackModelFactory = PropertiesProviderFactory(
        app: app,
        bundle: bundle,
        firstAppOpenUseCase: firstAppOpenUseCase,
        webViewUseCase: webViewUseCase,
        sessionManager: sessionManager,
        preferences: preferences,
        initPropertiesStorage: initPropertiesStorage,
        stringToSha256Converter: stringToSha256Converter,
        logsManager: logsManager,
        deeplinkClickRepository: deeplinkClickRepository,
        deviceUseCase: deviceUseCase,
        remarketingUseCase: remarketingUseCase,
        retrieveReferrerUseCase: retrieveReferrerUseCase,
        networkInfoUseCase: networkInfoUseCase,
        pushTokenUseCase: pushTokenUseCase
    ).create()

    lazy var retrieveReferrerUseCase: RetrieveReferrerUseCase = RetrieveReferrerUseCase()
    
    lazy var retrieveReferrerOnServerUseCase: RetrieveReferrerOnServerUseCase = RetrieveReferrerOnServerUseCase(
        moduleManager: moduleManager
    )

    lazy var moduleManager: AffiseModuleManager = AffiseModuleManager(
        bundle: bundle,
        logsManager: logsManager,
        postBackModelFactory: postBackModelFactory,
        initProperties: initProperties
    )

    lazy var debugValidateUseCase: DebugValidateUseCase = DebugValidateUseCaseImpl(
        initProperties: initProperties,
        postBackModelFactory: postBackModelFactory,
        logsManager: logsManager,
        networkService: networkService,
        converter: providersToJsonStringConverter
    )
    lazy var debugNetworkUseCase: DebugNetworkUseCase = DebugNetworkUseCaseImpl(
        initProperties: initProperties,
        networkService: networkService
    )
}
