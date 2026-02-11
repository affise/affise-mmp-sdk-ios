import Foundation

/**
 * Method of connection
 */
public enum NetworkServiceMethod: String {
    case GET = "GET"
    case POST = "POST"
}

public protocol NetworkService {
    
    func setDebug(_ debugRequest: @escaping DebugOnNetworkCallback)

    /**
     * Create request and execute result
     * Executes [method] on url [httpsUrl] with body of [data] and [headers]
     *
     * @return string representation of request
     */
    func executeRequest(
        httpsUrl: URL,
        method: NetworkServiceMethod,
        data: Data?,
        timeout: TimeInterval,
        headers: [String:String],
        redirect: Bool,
        skipBody: Bool
    ) -> HttpResponse
}
