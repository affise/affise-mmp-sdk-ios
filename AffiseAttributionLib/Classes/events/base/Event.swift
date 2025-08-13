import Foundation

/**
 * Base event
 */

@objc
open class Event: NSObject {

    /**
     * Event predefined parameters
     */
    private var predefinedParameters: [(String, Any?)] = []

    /**
     * Is first for user, default false
     */
    private var firstForUser: Bool = false

    /**
     * Serialize event to Dictionary
     *
     * @return Dictionary
     */
    func serialize() -> [(String, Any?)] { return [] }

    /**
     * Name of event
     *
     * @return name
     */
    open func getName() -> String { return "" }

    /**
     * Category of event
     *
     * @return category
     */
    func getCategory() -> String { return "" }

    /**
     * User data
     *
     * @return userData
     */
    func getUserData() -> String? { return nil }

    /**
     * Is first for user, default false
     *
     * @return is first for user or not
     */
    func isFirstForUser() -> Bool { return firstForUser }

    func setFirstForUser(_ firstForUser: Bool) {
        self.firstForUser = firstForUser
    }

    /**
     * Add predefined [parameter] with [value] type String to event
     */
    @objc
    public func addPredefinedParameter(_ parameter: PredefinedString, string: String) -> Event {
        predefinedParameters.append((parameter.value(), string))
        return self
    }

    /**
     * Add predefined [parameter] with [value] type Array of String to event
     */
    @objc
    public func addPredefinedParameter(_ parameter: PredefinedListString, listString: [String]) -> Event {
        predefinedParameters.append((parameter.value(), listString))
        return self
    }

    /**
     * Add predefined [parameter] with [value] type Int64 to event
     */
    @objc
    public func addPredefinedParameter(_ parameter: PredefinedLong, long: Int64) -> Event {
        predefinedParameters.append((parameter.value(), long))
        return self
    }

    /**
     * Add predefined [parameter] with [value] type Float to event
     */
    @objc
    public func addPredefinedParameter(_ parameter: PredefinedFloat, float: Float) -> Event {
        predefinedParameters.append((parameter.value(), float))
        return self
    }

    /**
     * Add predefined [parameter] with [value] type JSON to event
     */
    public func addPredefinedParameter(_ parameter: PredefinedObject, object: [(String, Any?)]) -> Event {
        predefinedParameters.append((parameter.value(), object))
        return self
    }
    /**
     * Add predefined [parameter] with [value] type JSON to event
     */
    @objc
    public func addPredefinedParameter(_ parameter: PredefinedObject, object: [[String: AnyObject]]) -> Event {
        return addPredefinedParameter(parameter, object: object.toFlatList())
    }

    /**
     * Add predefined [parameter] with [value] type Array of JSON to event
     */
    public func addPredefinedParameter(_ parameter: PredefinedListObject, listObject: [[(String, Any?)]]) -> Event {
        predefinedParameters.append((parameter.value(), listObject))
        return self
    }

    /**
     * Add predefined [parameter] with [value] type Array of JSON to event
     */
    @objc
    public func addPredefinedParameter(_ parameter: PredefinedListObject, listObject: [[String: AnyObject]]) -> Event {
        return addPredefinedParameter(parameter, listObject: listObject.toListOfList())
    }

    /**
     * Store and send this event
     */
    @objc
    public func send() {
        Affise.sendEvent(self)
    }

    /**
     * Send this event
     */
    @objc
    public func sendNow(_ success: @escaping OnSendSuccessCallback, _ failed: @escaping OnSendFailedCallback) {
        Affise.sendEventNow(self, success, failed)
    }

    @objc
    public func apply(closure:(Event) -> ()) -> Event {
        closure(self)
        return self
    }

    internal func getPredefinedParameters() -> [(String, Any?)] {
        for (key, value) in predefinedCustom.get() {
            replaceParameter(key, value)
        }
        return predefinedParameters
    }

    private func replaceParameter(_ key: String, _ value: Any?) {
        for (idx, (idxKey, _)) in predefinedParameters.enumerated() {
            if idxKey == key {
                predefinedParameters.remove(at: idx)
                break
            }
        }
        predefinedParameters.append((key, value))
    }

    private let predefinedCustom: PredefinedCustom = PredefinedCustom()

    @objc
    public func customPredefined() -> PredefinedCustom {
        return predefinedCustom
    }

    func addRawParameters(_ parameters: [AnyHashable:Any?]?) {
        guard let parameters = parameters else { return }
        for (key, value) in parameters {
            if value == nil { continue }
            predefinedParameters.append(("\(PredefinedConstants.PREFIX)\(key)", value))
        }
    }
}
