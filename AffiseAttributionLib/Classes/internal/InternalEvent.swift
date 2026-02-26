import Foundation

/**
 * Base internal event
 */

@objc
internal class InternalEvent: NSObject {
    
    let builder: AffisePropertyBuilder = AffisePropertyBuilder()

    /**
     * Serialize event to Dictionary
     *
     * @return Dictionary
     */
    func serialize() -> [(String, Any?)] { return builder.build() }

    /**
     * Name of event
     *
     * @return name
     */
    func getName() -> InternalEventName? { return nil }

    /**
     * Timestamp of event
     *
     * @return timestamp
     */
    func getTimestamp() -> Int64 { return Date().timeIntervalSince1970.timeInMillis }
    
    func serializeBuilder() -> AffisePropertyBuilder {
        return builder
    }
    
    @discardableResult
    func addProperty(_ property: InternalProperty, _ value: Any?) -> InternalEvent {
        builder.addRaw(property.type, value: value)
        return self
    }
    
    @discardableResult
    func addPropertyRaw(_ property: String, _ value: Any?) -> InternalEvent {
        builder.addRaw(property, value: value)
        return self
    }
    
    func send() {
        AffiseInternal.sendInternalEvent(self)
    }
}
