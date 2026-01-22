internal class LogsManagerImpl {
    private let storeLogsUseCase: StoreLogsUseCase
    
    init(storeLogsUseCase: StoreLogsUseCase) {
        self.storeLogsUseCase = storeLogsUseCase
    }
}

extension LogsManagerImpl: LogsManager {
    /**
     * Add network [throwable] to logs
     */
    func addNetworkError(error: Error) {
        
        var log: [(String, Any?)]
        
        switch error {
        case is AffiseError:
            log = createCloudExceptionJson(cloudException: error as! AffiseError)
            break
            
        default:
            log = [
                ("network_error", error.localizedDescription.toJsonGuardString())
            ]
        }
        
        //Store log
        storeLog(
            event: AffiseLog.NetworkLog(jsonObject: log)
        )
    }
    
    /**
     * Add device [throwable] to logs
     */
    func addDeviceError(error: Error) {
        //Create DevicedataLog
        storeLog(
            event: AffiseLog.DevicedataLog(
                value: error.localizedDescription.toJsonGuardString()
            )
        )
    }
    
    /**
     * Add user [throwable] to logs
     */
    func addUserError(error: Error) {
        //Create UserdataLog
        storeLog(
            event: AffiseLog.UserdataLog(
                value: error.localizedDescription.toJsonGuardString()
            )
        )
    }
    
    /**
     * Add user [throwable] to logs
     */
    func addUserError(message: String) {
        //Create UserdataLog
        storeLog(
            event: AffiseLog.UserdataLog(
                value: message
            )
        )
    }
    
    /**
     * Add sdk [throwable] to logs
     */
    func addSdkError(error: Error) {
        //Create SdkLog
        storeLog(
            event: AffiseLog.SdkLog(
                value: error.localizedDescription.toJsonGuardString()
            )
        )
    }
    
    /**
     * Add device [message] to logs
     */
    func addDeviceError(message: String) {
        //Create DevicedataLog
        storeLog(
            event: AffiseLog.DevicedataLog(value: message)
        )
    }
    
    /**
     * Store [event] to logs
     */
    private func storeLog(event: AffiseLog) {
        storeLogsUseCase.storeLog(log: event)
    }
    
    /**
     * Create exception json from [cloudException]
     */
    private func createCloudExceptionJson(cloudException: AffiseError) -> [(String, Any?)] {
        
        //Error data
        var data: String = ""
        
        //Error code
        var code: Int?
        
        var dict: [(String, Any?)] = []
        
        //Check throwable
        switch cloudException {
            
        case .cloud(url: let url, error: let error, attempts: let attempts, retry: let retry):
            data = error.localizedDescription
            code = nil
            
            if case let .network(status, _) = error as? AffiseError {
                code = status
            }
            
            //Add url
            dict.append(("endpoint", url))
            
            //Add code
            dict.append(("code", code))
            
            //Add attempts count
            dict.append(("attempts", attempts))
            
            //Add is retry sending
            dict.append(("retry", retry))
        case .network(status: let status, message: let message):
            data = message ?? ""
            code = status
            
            //Add code
            dict.append(("code", code))
        default:
            break
        }
        
        //Add message
        dict.append(("message", data))
        
        return dict
    }
}
