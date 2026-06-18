/**
 * Base property provider
 */
open class PropertyProvider<T> : Provider {
    open func getOrder() -> Float {
        0
    }
    
    open func getKey() -> ProviderType? {
        nil
    }
    
    /**
     * Default value of provider
     */
    private let defaultValue: T
    
    init(_ defaultValue: T) {
        self.defaultValue = defaultValue
    }
    
    /**
     * Provide data
     */
    open func provide() -> T? { nil }
    
    /**
     * Provide data with default value
     */
    func provideWithDefault() -> T {
        return provide() ?? defaultValue
    }
}

/**
 * Base string property provider
 */
open class StringPropertyProvider : PropertyProvider<String> {
    public init() {
        super.init("")
    }
}

/**
 * Base boolean property provider
 */
open class BooleanPropertyProvider : PropertyProvider<Bool> {
    public init() {
        super.init(false)
    }
}

/**
 * Base long property provider
 */
open class LongPropertyProvider : PropertyProvider<Int64> {
    public init() {
        super.init(0)
    }
}

/**
 * Base float property provider
 */
open class FloatPropertyProvider : PropertyProvider<Double> {
    public init() {
        super.init(0.0)
    }
}

/**
 * Base string property provider with param
 */
open class StringWithParamPropertyProvider : Provider {
    public func getOrder() -> Float {
        0
    }
    
    public func getKey() -> ProviderType? {
        nil
    }
    
    /**
     * Default value of provider
     */
    private let defaultValue = ""

    /**
     * Provide data with param
     */
    func provideWithParam(_ param: String) -> String? { nil }

    /**
     * Provide data with param and default value
     */
    func provideWithParamAndDefault(param: String) -> String {
        return provideWithParam(param) ?? defaultValue
    }
}
