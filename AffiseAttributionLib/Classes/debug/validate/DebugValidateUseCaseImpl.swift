import Foundation

class DebugValidateUseCaseImpl {
    
    private static let TIME_DELAY_SENDING: TimeInterval = 5
    private let ATTEMPTS_TO_SEND = 2
    private let TIMEOUT_SEND: TimeInterval = 30
    
    let KEY = "message"
    let INVALID_APP_ID = "Invalid affise_app_id"
    let INVALID_CHECK_SUM = "Failed to get application or check sum"
    let PACKAGE_NAME_NOT_FOUND = "Package name not found"
    
    let PATH = "postback/validate"
    var url: String = ""

    let initProperties: AffiseInitProperties
    let logsManager: LogsManager
    let converter: ProvidersToJsonStringConverter
    let networkService: NetworkService
    let providers: [Provider]

    init(
        initProperties: AffiseInitProperties,
        postBackModelFactory: PostBackModelFactory,
        logsManager: LogsManager,
        networkService: NetworkService,
        converter: ProvidersToJsonStringConverter
    ) {
        self.initProperties = initProperties
        self.logsManager = logsManager
        self.networkService = networkService
        self.converter = converter

        self.providers = postBackModelFactory.getRequestProviders()
        
        self.url = CloudConfig.getURL(PATH)
    }

    private func createRequest() -> HttpResponse {
        guard let httpsUrl = url.toURL() else { return HttpResponse(0, "", nil) }
 
        //Create request
        return networkService.executeRequest(
            httpsUrl: httpsUrl,
            method: .POST,
            data: converter.convert(from: providers).toData(),
            timeout: TIMEOUT_SEND,
            headers: CloudConfig.headers,
            redirect: true,
            skipBody: false
        )
    }

    private func getValidationStatus(_ response: HttpResponse) -> ValidationStatus? { // wtf server?
        if response.code == 0 {
            return ValidationStatus.NETWORK_ERROR
        }

        do { 
            //Create json
            let dict = try JSONSerialization.jsonObject(with: (response.body ?? "{}").data(using: .utf8)!, options: .mutableContainers) as? [String: Any?]
            let message: String = dict?[KEY] as? String ?? ""
            
            if message.caseInsensitiveCompare(INVALID_APP_ID) == .orderedSame {
                return ValidationStatus.INVALID_APP_ID
            }
            if message.caseInsensitiveCompare(PACKAGE_NAME_NOT_FOUND) == .orderedSame {
                return ValidationStatus.PACKAGE_NAME_NOT_FOUND
            }
            if message.caseInsensitiveCompare(INVALID_CHECK_SUM) == .orderedSame {
                return ValidationStatus.INVALID_SECRET_KEY
            }
        } catch {
        }
        
        if response.code == 200 {
            return ValidationStatus.VALID
        }
        return nil
    }
}

extension DebugValidateUseCaseImpl: DebugValidateUseCase {
    
    func validate(_ onComplete: @escaping DebugOnValidateCallback) {
        if initProperties.isProduction == true {
            onComplete(.NOT_WORKING_ON_PRODUCTION)
            return
        }

        DispatchQueue.global(qos:.background).async { [weak self] in
            self?.sendWithRepeat(onComplete) {
                Thread.sleep(forTimeInterval: DebugValidateUseCaseImpl.TIME_DELAY_SENDING)
            }
        }
    }
    
    func sendWithRepeat( _ onComplete: @escaping DebugOnValidateCallback, onFailedAttempt: () -> Void) {
        //attempts to send
        var attempts = ATTEMPTS_TO_SEND
        
        //Send or not
        var send = false

        //While has attempts and not send
        while (attempts != 0 && !send) {
            let status = getValidationStatus(createRequest())
            if let status = status {
                onComplete(status)
                //Send is ok
                send = true
            } else {
                attempts = attempts - 1
                //Check attempts
                if (attempts == 0) {
                    onComplete(ValidationStatus.NETWORK_ERROR)
                } else {
                    onFailedAttempt()
                }
            }
        }
    }
}
