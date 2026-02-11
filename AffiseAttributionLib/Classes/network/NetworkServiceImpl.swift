import Foundation

public class NetworkServiceImpl {
    private let urlSession: URLSession
    private var debugRequest: DebugOnNetworkCallback?
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession;
    }
}

extension NetworkServiceImpl: NetworkService {
    
    public func setDebug(_ debugRequest: @escaping DebugOnNetworkCallback) {
        self.debugRequest = debugRequest
    }

    public func executeRequest(
        httpsUrl: URL,
        method: NetworkServiceMethod,
        data: Data?,
        timeout: TimeInterval,
        headers: [String:String],
        redirect: Bool = true,
        skipBody: Bool = false
    ) -> HttpResponse {
        var responseCode: Int = 0
        var responseMessage: String = ""
        var responseBody: String? = nil
        var responseHeaders: [String:[String]] = [:]
        
        var request = URLRequest.init(url: httpsUrl)
        request.httpMethod = method.rawValue
        request.httpShouldHandleCookies = false;
        request.httpBody = data
        let contentLength = "\(data?.count ?? 0)"
        request.addValue(contentLength, forHTTPHeaderField: "Content-Length")
        request.timeoutInterval = timeout
        
        headers.forEach { (key: String, value: String) in
            request.addValue(value, forHTTPHeaderField: key)
        }
        request.addValue("must-revalidate, no-store, no-cache", forHTTPHeaderField: "Cache-Control")

        var complete: Bool = false
        
        let task = urlSession.dataTask(
            redirect: redirect, 
            skipBody: skipBody, 
            with: request
        ) { responseData, response, error in
            let httpResponse = (response as? HTTPURLResponse)

            responseBody = responseData?.toString()
            responseCode = httpResponse?.statusCode ?? 0
            responseMessage = error?.localizedDescription ?? ""
            responseHeaders = httpResponse?.allHeaders() ?? [:]

            complete = true
        }
        task.resume()
      
        while !complete {
            Thread.sleep(forTimeInterval: 1)
        }

        let httpResponse = HttpResponse(responseCode, responseMessage, responseBody?.toSinglQuote, responseHeaders)
        if let debugRequest = debugRequest {
            debugRequest(HttpRequest(httpsUrl, method, headers, data?.toString()), httpResponse)
        }
        return httpResponse
    }
}
