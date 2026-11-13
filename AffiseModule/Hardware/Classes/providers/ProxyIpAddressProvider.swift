import AffiseAttributionLib
import Foundation

/**
 * Provider for parameter [ProviderType.PROXY_IP_ADDRESS]
 */
class ProxyIpAddressProvider: StringPropertyProvider {
    
    override func provide() -> String? {
        return getProxyName()
    }
    
    private func getProxyName() -> String? {
        if let proxySettingsUnmanaged = CFNetworkCopySystemProxySettings() {
            let proxySettings = proxySettingsUnmanaged.takeRetainedValue()
            if let dict = proxySettings as? [String: AnyObject],
                let value = dict[kCFNetworkProxiesHTTPProxy as String] as? String {
                
                return value;
            }
        }
        return nil;
    }
    
    public override func getOrder() -> Float {
        24.1
    }

    public override func getKey() -> ProviderType? {
        ProviderType.PROXY_IP_ADDRESS
    }
}
