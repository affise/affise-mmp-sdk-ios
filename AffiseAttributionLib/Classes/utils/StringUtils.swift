import Foundation

public func isNullOrBlank(_ text: String?) -> Bool {
    guard let text = text else {
        return true
    }
    return text.isEmpty 
}

public extension Data {
    func toString() -> String? {
        return String.init(data: self, encoding: .utf8)
    }
}

public extension String {
    func toData() -> Data? {
        return self.data(using: .utf8)
    }
    
    func toURL() -> URL? {
        return Foundation.URL(string: self)
    }
    
    func toJsonGuardString() -> String {
        return self.replacingOccurrences(of: "\"", with: "\\\"")
    }

    internal func jsonStringUnescape() -> String {
        return self.toJsonGuardString()
            .replacingOccurrences(of: "{", with: "\\\\{")
            .replacingOccurrences(of: "}", with: "\\\\}")
    }
    
    var toSinglQuote: String {
        return self.replacingOccurrences(of: "\\\"", with: "\'")
    }
    
    var isBlank: Bool {
        return allSatisfy { $0.isWhitespace }
    }

    internal func getQueryStringParameter(_ param: String) -> String? {
        guard let url = URLComponents(string: self) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }
}


extension Optional  where Wrapped == String {
    
    public var isNullOrBlank: Bool {
        get {
            return self?.isBlank ?? true
        }
    }
}
