import Foundation
import AffiseAttributionLib

@objc(AffiseLinkModule)
public final class LinkModule: AffiseModule, AffiseLinkApi {
    
    public override var version: String { BuildConfig.AFFISE_VERSION }
    
    private var useCase: LinkResolveUseCase? = nil
        
    public override func start() {
        let networkService: NetworkService? = get()
        if networkService == nil
        {
            print(AffiseModuleError.initModule(name: .Link).localizedDescription)
            return
        }

        useCase = LinkResolveUseCaseImpl(
            networkService: networkService!
        )
    }
    
    public func resolve(_ url: String, _ callback: @escaping AffiseLinkCallback) {
        useCase?.linkResolve(url, callback) ?? callback("")
    }
}
