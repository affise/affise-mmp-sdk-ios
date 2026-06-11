import AffiseAttributionLib
import Foundation

@objc(AffiseGoogleModule)
public final class GoogleModule: AffiseModule {

    public override var version: String { BuildConfig.AFFISE_VERSION }

    private var googleOdmUseCase: GoogleOdmUseCase? = nil

    private var odmInfoProvider: Provider? = nil

    private var newProviders: [Provider] = []

    override public func start() {
        let firstAppOpenUseCase: FirstAppOpenUseCase? = get()
        if firstAppOpenUseCase == nil {
            print(AffiseModuleError.initModule(name: .Google).localizedDescription)
            return
        }

        let useCase = GoogleOdmUseCaseImpl(firstAppOpenUseCase: firstAppOpenUseCase!)
        let provider = OdmInfoProvider(googleOdmUseCase: useCase)

        googleOdmUseCase = useCase
        odmInfoProvider = provider
        googleOdmUseCase?.initialize()

        newProviders = [
            provider
        ]
    }

    override public func providers() -> [Provider] {
        newProviders
    }
}
