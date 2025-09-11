import Foundation


public class AffiseInitProperties: NSObject {
    let affiseAppId: String?
    let partParamName: String?
    let partParamNameToken: String?
    let appToken: String?
    let isProduction: Bool
    let secretKey: String?
    let domain: String?
    let onInitSuccessHandler: OnInitSuccessHandler?
    let onInitErrorHandler: OnInitErrorHandler?
    // let configValues: [AffiseConfig: Any]
    let disableModules: [AffiseModules]
    
    public init(
        affiseAppId: String?,
        partParamName: String? = nil,
        partParamNameToken: String? = nil,
        appToken: String? = nil,
        isProduction: Bool = true,
        secretKey: String? = nil,
        domain: String? = nil,
        onInitSuccessHandler: OnInitSuccessHandler? = nil,
        onInitErrorHandler: OnInitErrorHandler? = nil,
        // configValues: [AffiseConfig: Any] = [:],
        disableModules: [AffiseModules] = []
    ) {
        self.affiseAppId = affiseAppId
        self.partParamName = partParamName
        self.partParamNameToken = partParamNameToken
        self.appToken = appToken
        self.isProduction = isProduction
        self.secretKey = secretKey
        self.domain = domain
        self.onInitSuccessHandler = onInitSuccessHandler
        self.onInitErrorHandler = onInitErrorHandler
        // self.configValues = configValues
        self.disableModules = disableModules
        
        CloudConfig.setupDomain(domain)
    }

    public convenience init(
        affiseAppId: String,
        secretKey: String
    ) {
        self.init(
            affiseAppId: affiseAppId,
            partParamName: nil,
            partParamNameToken: nil,
            appToken: nil,
            isProduction: true,
            secretKey: secretKey,
            domain: nil,
            onInitSuccessHandler: nil,
            onInitErrorHandler: nil,
            // configValues: [:],
            disableModules: []
        )
    }

    public convenience init(
        affiseAppId: String,
        secretKey: String,
        isProduction: Bool
    ) {
        self.init(
            affiseAppId: affiseAppId,
            partParamName: nil,
            partParamNameToken: nil,
            appToken: nil,
            isProduction: isProduction,
            secretKey: secretKey,
            domain: nil,
            onInitSuccessHandler: nil,
            onInitErrorHandler: nil,
            // configValues: [:],
            disableModules: []
        )
    }
}
