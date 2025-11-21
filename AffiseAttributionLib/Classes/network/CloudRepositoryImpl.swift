import Foundation

internal class CloudRepositoryImpl {

    private let ATTEMPTS_TO_SEND = 3
    private let TIMEOUT_SEND: TimeInterval = 30

    private let networkService: NetworkService
    private let userAgentProvider: UserAgentProvider?
    private let converter: PostBackModelToJsonStringConverter

    init(networkService: NetworkService,
         userAgentProvider: UserAgentProvider?,
         converter: PostBackModelToJsonStringConverter) {
        
        self.networkService = networkService
        self.userAgentProvider = userAgentProvider
        self.converter = converter
    }

    /**
     * Create headers
     */
    private func createHeaders() -> Dictionary<String, String> {
        return [
            "User-Agent" : (userAgentProvider?.provideWithDefault() ?? ""),
            "Content-Type" : "application/json; charset=utf-8"
        ]
    }
}


extension CloudRepositoryImpl: CloudRepository {
    
    /**
     * Send [data] for [url] if [url]
     * @throws CloudException contains throwable for url
     */
    func send(data: Array<PostBackModel>, url: String) throws {
        //attempts to send
        var attempts = ATTEMPTS_TO_SEND
        
        //Send or not
        var send = false
        
        //While has attempts and not send
        while (attempts != 0 && !send) {
            //Create request
            let response =  createRequest(url: url, data: data)
            
            if response.isHttpValid() {
                //Send is ok
                send = true
            } else {
                attempts = attempts - 1
                //Check attempts
                if (attempts == 0) {
                    let error = AffiseError.network(status: response.code, message: nil)
                    //Add throwable
                    throw AffiseError.cloud(url: url, error: error, attempts: ATTEMPTS_TO_SEND, retry: true)
                }
            }
        }
    }

      /**
     * Send [data] to [url]
     */
    func createRequest(url: String, data: [PostBackModel]) -> HttpResponse {
        guard let httpsUrl = url.toURL() else { return HttpResponse(0, "", nil) }
        
        //Create request
        return networkService.executeRequest(
            httpsUrl: httpsUrl,
            method: .POST,
            data: converter.convert(from: data).toData(),
            timeout: TIMEOUT_SEND,
            headers: createHeaders(),
            redirect: true
        )
    }
}
