public extension Array where Element == Provider {
    func getProvider<T>() -> T? where T : Provider {
        self.first(where: { $0 is T }) as? T
    }

    func mapProviders() -> [(ProviderType, Any?)] {
        var result: [(ProviderType, Any?)] = []
        let createdTimeProvider: CreatedTimeProvider? = self.getProvider()
        let createdTime  = createdTimeProvider?.provideWithDefault() ?? 0
        let sortedArray = self.filter{ $0.getKey() != nil}.sorted(by: {$0.getOrder() < $1.getOrder()})
        
        for provider in sortedArray {
            guard let key = provider.getKey() else {
                continue
            }
            let value = provider.getValue(createdTime:createdTime)
            result += [(key, value)]
        }
        return result
    }
    
    func getProviders(_ types: [Provider.Type]) -> [Provider] {
        return self.filter { p in
            types.contains(where: { type(of: p) == $0 })
        }
    }
    
    func getRequestProviders() -> [Provider] {
        return getProviders([
            CreatedTimeProvider.self,
            AffiseAppIdProvider.self,
            AffisePackageAppNameProvider.self,
            AffAppTokenPropertyProvider.self,
            AffiseDeviceIdProvider.self,
            RandomUserIdProvider.self
        ])
    }
}

internal extension Provider {
    func getValue(createdTime: Int64) -> Any? {
        switch self {
        case is CreatedTimeProvider:
            return createdTime
        case is AffAppTokenPropertyProvider:
            return (self as? AffAppTokenPropertyProvider)?.provideWithParamAndDefault(param: String(createdTime))

        case is StringPropertyProvider:
            return (self as? StringPropertyProvider)?.provideWithDefault()
        case is BooleanPropertyProvider:
            return (self as? BooleanPropertyProvider)?.provideWithDefault()
        case is LongPropertyProvider:
            return (self as? LongPropertyProvider)?.provideWithDefault()
        case is FloatPropertyProvider:
            return (self as? FloatPropertyProvider)?.provideWithDefault()
        default:
            return nil
        }
    }
}
