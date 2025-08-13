import Foundation

/**
 * Event UserCustom
 *
 * @property eventName custom event name.
 * @property userData any custom data.
 * @property timeStampMillis the timestamp event in milliseconds.
 */
@objc
open class UserCustomEvent : NativeEvent {

    private var eventName: String = ""
    private var category: String? = nil

    @objc
    public init(
        eventName: String,
        userData: String? = nil,
        timeStampMillis: Int64 = timestamp(),
        category: String? = nil
    ) {
        super.init(userData, timeStampMillis: timeStampMillis)
        self.eventName = eventName
        self.category = category
    }

    override public func getName() -> String {
        return eventName
    }

    override public func getCategory() -> String { return category ?? super.getCategory() }
    
    /**
     * For internal use only
     */
    public func internalAddRawParameters(_ parameters: [AnyHashable:Any?]?) -> Event {
        addRawParameters(parameters)
        return self
    }
}
