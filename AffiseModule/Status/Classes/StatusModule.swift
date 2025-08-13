import Foundation
import AffiseAttributionLib

@objc(AffiseStatusModule)
public final class StatusModule: AffiseModule {
    
    public override var version: String { BuildConfig.AFFISE_VERSION }
    
    private var checkStatusUseCase: CheckStatusUseCase? = nil
    private var referrerUseCase: ReferrerUseCase? = nil
    
    private lazy var stringToKeyValueConverter: StringToKeyValueConverter = StringToKeyValueConverter()
        
    public override func start() {
        let providersToJsonStringConverter: ProvidersToJsonStringConverter? = get()
        let networkService: NetworkService? = get()
        let postBackModelFactory: PostBackModelFactory? = get()
        let postBackModelToJsonStringConverter: PostBackModelToJsonStringConverter? = get()
        
        if providersToJsonStringConverter == nil ||
            networkService == nil ||
            postBackModelFactory == nil ||
            postBackModelToJsonStringConverter == nil
        {
            print(AffiseModuleError.initModule(name: .Status).localizedDescription)
            return
        }

        checkStatusUseCase = CheckStatusUseCaseImpl(
            affiseModule: self,
            logsManager: logsManager,
            networkService: networkService!,
            converter: providersToJsonStringConverter!,
            keyValueConverter: stringToKeyValueConverter,
            postBackModelFactory: postBackModelFactory!,
            postBackModelToJsonStringConverter: postBackModelToJsonStringConverter!
        )

        referrerUseCase = ReferrerUseCaseImpl(
            checkStatusUseCase: checkStatusUseCase
        )
    }
    
    public override func status(_ onComplete: @escaping OnKeyValueCallback) {
        guard let checkStatusUseCase = checkStatusUseCase else {
            onComplete([])
            return
        }
        checkStatusUseCase.send { status in
            onComplete(status)
            let _ = self.referrerUseCase?.parseStatus(status)
        }
    }
}


extension StatusModule : ReferrerCallback {
    public func getReferrer(_ callback: @escaping OnReferrerCallback) {
        referrerUseCase?.getReferrer(callback) ?? callback(nil)
    }
}
