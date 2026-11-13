import AffiseAttributionLib
import Foundation

@objc(AffiseHardwareModule)
public final class HardwareModule: AffiseModule {
    public override var version: String { BuildConfig.AFFISE_VERSION }

    private lazy var deviceUseCase: DeviceUseCase = DeviceUseCaseImpl()
    private lazy var screenUseCase: ScreenUseCase = ScreenUseCaseImpl()
    private lazy var processInfoUseCase: ProcessInfoUseCase = ProcessInfoUseCaseImpl()
    private lazy var networkInfoUseCase: NetworkInfoUseCase = NetworkInfoUseCaseImpl()
    private lazy var remarketingUseCase: RemarketingUseCase = RemarketingUseCaseImpl(deviceUseCase: deviceUseCase)
    private lazy var webViewUseCase = WebViewUseCase(preferences: UserDefaults.standard)
    private var newProviders: [Provider] = []

    public override func start() {
        webViewUseCase.initialize()
        newProviders = [
            UserAgentProvider(useCase: webViewUseCase),
            CpuTypeProvider(useCase: processInfoUseCase),
            CpuCoresProvider(useCase: processInfoUseCase),
            DeviceProvider(remarketingUseCase),
            BuildProvider(remarketingUseCase),
            DeviceNameProvider(useCase: deviceUseCase),
            ProxyIpAddressProvider(),
            ScreenWidthProvider(useCase: screenUseCase),
            ScreenHeightProvider(useCase: screenUseCase),
            DensityProvider(useCase: screenUseCase),
            HardwareNameProvider(useCase: deviceUseCase),
            DeviceTypeProvider(useCase: deviceUseCase),
            OSVersionProvider(useCase: deviceUseCase),
            OsAndVersionProvider(remarketingUseCase),
            MCCProvider(useCase: networkInfoUseCase),
            MNCProvider(useCase: networkInfoUseCase),
            IspNameProvider(useCase: networkInfoUseCase),
            NetworkTypeProvider(),
            ConnectionTypeProvider(),
            TimezoneDeviceProvider(),
            LanguageProvider(remarketingUseCase),
            CountryProvider(),
            RegionProvider(),
            DeviceManufacturerProvider(),
            OsNameProvider(useCase: deviceUseCase)
        ]
    }

    public override func providers() -> [Provider] {
        return newProviders
    }
}
