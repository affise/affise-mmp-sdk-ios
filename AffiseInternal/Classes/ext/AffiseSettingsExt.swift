import AffiseAttributionLib


internal class Field {
    static let AFFISE_APP_ID = "affiseAppId"
    static let SECRET_KEY = "secretKey"
    static let PART_PARAM_NAME = "partParamName"
    static let PART_PARAM_NAME_TOKEN = "partParamNameToken"
    static let APP_TOKEN = "appToken"
    // static let AUTO_CATCHING_CLICK_EVENTS = "autoCatchingClickEvents"
    static let IS_PRODUCTION = "isProduction"
    // static let ENABLED_METRICS = "enabledMetrics"
    static let DOMAIN = "domain"
    static let CONFIG_STRINGS = "configStrings"
    static let DISABLE_MODULES = "disableModules"
}

internal extension Dictionary where Key == String, Value == Any? {

    func getString(_ key: String) -> String? {
        return self[key] as? String
    }
    
    func getBool(_ key: String) -> Bool? {
        return self[key] as? Bool
    }
    func getMap(_ key: String) -> [String:Any?]? {
        return self[key] as? [String:Any?]
    }
    func getList(_ key: String) -> [Any?]? {
        return self[key] as? [Any?]
    }
    
    func isValid() -> Bool {
        guard let affiseAppId = self.getString(Field.AFFISE_APP_ID) else { return false }
        if affiseAppId.isEmpty { return false }
        guard let secretKey = self.getString(Field.SECRET_KEY) else { return false }
        if secretKey.isEmpty { return false }
        
        return true
    }
    
    func getAppIdAndSecretKey() -> (String, String) {
        return (self.getString(Field.AFFISE_APP_ID) ?? "", self.getString(Field.SECRET_KEY) ?? "")
    }
}

internal func toAffiseModules(_ values: [Any?]?) -> [AffiseModules]? {
    guard let values = values as? [String] else { return nil }
    return values.compactMap { AffiseModules.from($0) }
}

internal extension AffiseSettings {
    func addSettings(_ data: [String: Any?]) -> AffiseSettings {
        if let value = data.getString(Field.DOMAIN) {
            _ = self.setDomain(value)
        }
        
        if let value = data.getBool(Field.IS_PRODUCTION) {
            _ = self.setProduction(value)
        }
        
        if let value = data.getString(Field.PART_PARAM_NAME) {
            _ = self.setPartParamName(value)
        }
        
        if let value = data.getString(Field.PART_PARAM_NAME_TOKEN) {
            _ = self.setPartParamNameToken(value)
        }
        
        if let value = data.getString(Field.APP_TOKEN) {
            _ = self.setAppToken(value)
        }

        // if let value = data.getMap(Field.CONFIG_STRINGS) {
        //     for (k, v) in value {
        //         guard let v = v else { continue }
        //         guard let configKey = AffiseConfig.from(k) else { continue }
        //         _ = self.setConfigValue(configKey, value)
        //     }
        // }

        if let value = toAffiseModules(data.getList(Field.DISABLE_MODULES)) {
            _ = self.setDisableModules(value)
        }
        
        return self
    }
}
