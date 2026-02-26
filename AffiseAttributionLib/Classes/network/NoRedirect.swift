import Foundation


internal class NoRedirect: NSObject, URLSessionTaskDelegate, @unchecked Sendable {
        
    private static let shared: NoRedirect = NoRedirect()
    
    static let urlSession: URLSession = shared.session
    
    private var session: URLSession = URLSession.shared
        
    private override init() {
        super.init()
        self.session = URLSession(configuration: .ephemeral, delegate: self, delegateQueue: nil)
    }
    
    // URLSessionTaskDelegate method to handle redirection
    func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        willPerformHTTPRedirection response: HTTPURLResponse,
        newRequest request: URLRequest,
        completionHandler: @escaping (URLRequest?) -> Void
    ) {
        // Call the completion handler with nil to prevent the redirection from happening
        completionHandler(nil)
    }
}

internal class NoRedirectHeadOnly: NSObject, URLSessionDataDelegate {
    
    private var session: URLSession = URLSession.shared
    
    private var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    
    override init() {
        super.init()
        self.session = URLSession(configuration: .ephemeral, delegate: self, delegateQueue: nil)
    }
    
    func loadHead(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.completionHandler = completionHandler
        return session.dataTask(with: request)
    }
    
    func complete(_ task: URLSessionTask, _ response: HTTPURLResponse?) {
        completionHandler?(nil, response, task.error)
        completionHandler = nil
    }

    func urlSession(
        _ session: URLSession,
        dataTask: URLSessionDataTask,
        didReceive response: URLResponse,
        completionHandler: @escaping (URLSession.ResponseDisposition) -> Void
    ) {
        complete(dataTask, response as? HTTPURLResponse)
        // Call the completion handler with .cancel to prevent body loading
        completionHandler(.cancel)
    }
    
    func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        willPerformHTTPRedirection response: HTTPURLResponse,
        newRequest request: URLRequest,
        completionHandler: @escaping (URLRequest?) -> Void
    ) {
        complete(task, response)
        // Call the completion handler with nil to prevent the redirection from happening
        completionHandler(nil)
    }
}


internal extension URLSession {
    func dataTask(redirect: Bool, skipBody: Bool, with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        if redirect == true {
            return self.dataTask(with: request, completionHandler: completionHandler)
        } else {
            if skipBody == false {
                return NoRedirect.urlSession.dataTask(with: request, completionHandler: completionHandler)
            } else {
                return NoRedirectHeadOnly().loadHead(with: request, completionHandler: completionHandler)
            }
        }
    }
}
