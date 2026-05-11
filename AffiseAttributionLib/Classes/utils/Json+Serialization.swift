import Foundation


internal extension String {
    func toJsonMap() -> [String: Any?]? {
        do {
            //Create json
            return try JSONSerialization.jsonObject(with: (self).data(using: .utf8)!, options: .mutableContainers) as? [String: Any?]
        } catch {
            debugPrint(error)
            return nil
        }
    }
}


internal func unescapeJson(_ data: Any?) -> Any? {
    guard let data = data else { return nil }
    if let data = data as? String {
        return data.jsonStringUnescape()
    } else if let data = data as? [Any] {
        return data.map { value in
            return unescapeJson(value)
        }
    } else if let (key, value) = data as? (String, Any?) {
        return (key, unescapeJson(value) as Any)
    } else if let data = data as? [(String, Any?)] {
        return data.map { value in
            return unescapeJson(value)
        }
    } else if let data = data as? [[(String, Any?)]] {
        return data.map { value in
            return unescapeJson(value)
        }
    } else {
        return data
    }
}
    
