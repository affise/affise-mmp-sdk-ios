import AffiseAttributionLib
import Foundation

class LinkResolveUseCaseImpl {

    private let MAX_REDIRECT_COUNT: Int = 10
    private let HEADER_LOCATION: String = "Location"

    let networkService: NetworkService

    init(
        networkService: NetworkService
    ) {
        self.networkService = networkService
    }

    private func resolve(_ url: String, _ callback: @escaping AffiseLinkCallback, _ maxSteps: Int) {
        //Create request
        let response = createRequest(url)        
        //Has redirect status
        if (response.isRedirect() && maxSteps > 0) {
            //Get first non blank location url
            let redirectUrl = response.headers[HEADER_LOCATION]?.first { !$0.isBlank }
            if !redirectUrl.isNullOrBlank {
                //Resolve redirect url
                resolve(redirectUrl ?? url, callback, maxSteps - 1)
            } else {
                //Return final url
                callback(url)
            }
        } else {
            //Return final url
            callback(url)
        }
    }


    private func createRequest(_ url: String) -> HttpResponse {
        guard let httpsUrl = url.toURL() else { return HttpResponse(0, "") }
        // Create request
        return networkService.executeRequest(
            httpsUrl: httpsUrl,
            method: .GET,
            data: nil,
            timeout: 0,
            headers: [:],
            redirect: false,
            skipBody: true
        )
    }
}

extension LinkResolveUseCaseImpl: LinkResolveUseCase {
    func linkResolve(_ url: String, _ callback: @escaping AffiseLinkCallback) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            self.resolve(url, callback, self.MAX_REDIRECT_COUNT)
        }
    }
}
