import Foundation
import AffiseAttributionLib

internal class CheckStatusUseCaseImpl {
    
    private static let TIME_DELAY_SENDING: TimeInterval = 1
    private static let TIMINGS = Array([1,1,2,3,5,8,13].reversed())
    private let TIMEOUT_SEND: TimeInterval = 30
    
    let PATH: String = "check_status"
    var url: String = ""
    var isPostBackSend: Bool = false

    let logsManager: LogsManager?
    let converter: ProvidersToJsonStringConverter
    let keyValueConverter: StringToKeyValueConverter
    let networkService: NetworkService
    let postBackModelFactory: PostBackModelFactory
    let postBackModelToJsonStringConverter: PostBackModelToJsonStringConverter
    
    let providers: [Provider]

    init(
        affiseModule: AffiseModule,
        logsManager: LogsManager?,
        networkService: NetworkService,
        converter: ProvidersToJsonStringConverter,
        keyValueConverter: StringToKeyValueConverter,
        postBackModelFactory: PostBackModelFactory,
        postBackModelToJsonStringConverter: PostBackModelToJsonStringConverter
    ) {
        self.logsManager = logsManager
        self.converter = converter
        self.keyValueConverter = keyValueConverter
        self.networkService = networkService
        self.postBackModelFactory = postBackModelFactory
        self.postBackModelToJsonStringConverter = postBackModelToJsonStringConverter
        self.providers = affiseModule.getRequestProviders()
        
        self.url = CloudConfig.getURL(PATH)
    }

    private func createRequest(_ data: String) -> HttpResponse {
        guard let httpsUrl = url.toURL() else { return HttpResponse(0, "", nil) }
        
        //Create request
        return networkService.executeRequest(
            httpsUrl: httpsUrl,
            method: .POST,
            data: data.toData(),
            timeout: TIMEOUT_SEND,
            headers: CloudConfig.headers,
            redirect: true,
            skipBody: false
        )
    }
    
    func providersData() -> String {
        return converter.convert(from: providers)
    }
    
    func postBackData() -> String {
        let data = postBackModelFactory.create(events: [], logs: [], metrics: [], internalEvents: [])
        return postBackModelToJsonStringConverter.convert(from: [data])
    }
}

extension CheckStatusUseCaseImpl: CheckStatusUseCase {

    func send(_ onComplete: @escaping OnKeyValueCallback) {
        DispatchQueue.global(qos:.background).async { [weak self] in
            self?.sendWithRepeat(onComplete) { attempt in
                var i = 1
                if CheckStatusUseCaseImpl.TIMINGS.count > attempt {
                    i = CheckStatusUseCaseImpl.TIMINGS[attempt]
                }
                Thread.sleep(forTimeInterval: CheckStatusUseCaseImpl.TIME_DELAY_SENDING * Double(i))
            }
        }
    }
    
    func sendWithRepeat( _ onComplete: @escaping OnKeyValueCallback, onFailedAttempt: (Int) -> Void) {
        //attempts to send
        var attempts = CheckStatusUseCaseImpl.TIMINGS.count + 1
        
        //Send or not
        var send = false

        //While has attempts and not send
        while (attempts != 0 && !send) {
            var postBackResponse: HttpResponse? = nil
            var response: HttpResponse? = nil
            
            if isPostBackSend == false {
                postBackResponse = createRequest(postBackData())
                if let postBackResponse = postBackResponse {
                    isPostBackSend = postBackResponse.isHttpValid()
                }
            }
            
            if isPostBackSend == true {
                response = createRequest(providersData())
            }
            
            if isPostBackSend && response?.isHttpValid() == true {
                onComplete(keyValueConverter.convert(from: response?.body ?? ""))
                
                //Send is ok
                send = true
            } else {
                attempts = attempts - 1
                //Check attempts
                if (attempts == 0) {
                    onComplete([])
                    
//                    let httpResponse = response ?? postBackResponse
//                    let error = AffiseError.network(status: httpResponse?.code ?? 0, message: nil)
//                    //Log error
//                    logsManager?.addSdkError(error: AffiseError.cloud(url: url, error: error, attempts: CheckStatusUseCaseImpl.TIMINGS.count + 1, retry: true))
                } else {
                    onFailedAttempt(attempts - 1)
                }
            }
        }
    }
}
