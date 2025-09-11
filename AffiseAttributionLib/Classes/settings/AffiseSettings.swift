import Foundation
import UIKit

@objc
public class AffiseSettings: NSObject {

    private let affiseAppId: String?
    private let secretKey: String?
    private var isProduction: Bool = true
    private var partParamName: String?
    private var partParamNameToken: String?
    private var appToken: String?
    private var domain: String?
    private var onInitSuccessHandler: OnInitSuccessHandler?
    private var onInitErrorHandler: OnInitErrorHandler?
    private var configValues: [AffiseConfig: Any] = [:]
    private var disableModules: [AffiseModules] = []
    
    @objc
    internal init(
        affiseAppId: String,
        secretKey: String
    ) {
        self.affiseAppId = affiseAppId
        self.secretKey = secretKey
    }
    
    /**
     * Set Affise SDK for SandBox / Production
     */
    @objc
    public func setProduction(_ production: Bool) -> AffiseSettings {
        self.isProduction = production
        return self
    }
    
    /**
     * Only for specific use case [partParamName]
     */
    @objc
    public func setPartParamName(_ partParamName: String) -> AffiseSettings {
        self.partParamName = partParamName
        return self
    }
    
    /**
     * Only for specific use case [partParamNameToken]
     */
    @objc
    public func setPartParamNameToken(_ partParamNameToken: String) -> AffiseSettings {
        self.partParamNameToken = partParamNameToken
        return self
    }
    
    /**
     * Set [appToken]
     */
    @objc
    public func setAppToken(_ appToken: String) -> AffiseSettings {
        self.appToken = appToken
        return self
    }
    
    /**
     * Set Affise SDK server [domain]
     * Triling slash is irrelivant
     */
    @objc
    public func setDomain(_ domain: String) -> AffiseSettings {
        self.domain = domain
        return self
    }

    /**
     * Set [onInitSuccessHandler]
     */
    @objc
    public func setOnInitSuccess(_ onInitSuccessHandler: @escaping OnInitSuccessHandler) -> AffiseSettings {
        self.onInitSuccessHandler = onInitSuccessHandler
        return self
    }

    /**
     * Set [onInitErrorHandler]
     */
    @objc
    public func setOnInitError(_ onInitErrorHandler: @escaping OnInitErrorHandler) -> AffiseSettings {
        self.onInitErrorHandler = onInitErrorHandler
        return self
    }

    /**
     * Set [configValues] value
     */
    // @objc
    // public func setConfigValue(_ key: AffiseConfig, _ value: Any) -> AffiseSettings {
    //     self.configValues[key] = value
    //     return self
    // }

    /**
     * Set [configValues] values
     */
    // @objc
    // public func setConfigValues(_ configValues: [AffiseConfig: Any]) -> AffiseSettings {
    //     for (key, value) in configValues {
    //         self.configValues[key] = value
    //     }
    //     return self
    // }
    
    @objc(setDisableModules:)
    public func setDisableModulesObjc(_ disableModules: Array<Int>) -> AffiseSettings {
        return setDisableModules(disableModules.compactMap { AffiseModules(rawValue: $0)})
    }

    public func setDisableModules(_ disableModules: [AffiseModules]) -> AffiseSettings {
        self.disableModules = disableModules
        return self
    }
    
    private func getInitProperties() -> AffiseInitProperties {
        return AffiseInitProperties(
            affiseAppId: affiseAppId,
            partParamName: partParamName,
            partParamNameToken: partParamNameToken,
            appToken: appToken,
            isProduction: isProduction,
            secretKey: secretKey,
            domain: domain,
            onInitSuccessHandler: onInitSuccessHandler,
            onInitErrorHandler: onInitErrorHandler,
            // configValues: configValues,
            disableModules: disableModules
        )
    }
    
    /**
     * Start Affise SDK using [app] and [launchOptions]
     */
    @objc
    public func start(
        app: UIApplication,
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) {
        Affise.start(initProperties: getInitProperties(), app: app, launchOptions: launchOptions)
    }
}
