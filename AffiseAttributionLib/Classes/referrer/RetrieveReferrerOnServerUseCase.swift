import Foundation

class RetrieveReferrerOnServerUseCase {

    private let moduleManager: AffiseModuleManager
    private var referrerModule: ReferrerCallback?

    init(
        moduleManager: AffiseModuleManager
    ) {
        self.moduleManager = moduleManager
    }

    private func getReferrerModule() -> ReferrerCallback? {
        if self.referrerModule != nil {
            return self.referrerModule
        }
        guard let module = moduleManager.getModule(.Status) else { return nil }
        guard let referrerModule = module as? ReferrerCallback else { return nil }
        self.referrerModule = referrerModule
        return referrerModule
    }
    
    private func handleReferrerOnServer(_ callback: @escaping OnReferrerCallback) {
        getReferrerModule()?.getReferrer(callback) ?? callback(nil)
    }
        
    /**
     * Return referrer on server
     */
    func getReferrerOnServer(_ callback: @escaping OnReferrerCallback) {
        handleReferrerOnServer { value in
            callback(value)
        }
    }
    
    /**
     * Return referrer on server parameter by key
     */
    func getReferrerOnServerValue(_ key: ReferrerKey, _ callback: @escaping OnReferrerCallback) {
        handleReferrerOnServer { value in
            callback("https://referrer/?\(value ?? "")".getQueryStringParameter(key.value()))
        }
    }
} 
