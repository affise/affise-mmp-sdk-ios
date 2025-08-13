import Foundation


@objc
public enum AffiseModules: Int {
    case AdService
    case Advertising
    case AppsFlyer
    case Link
    case Persistent
    case Status
    case Subscription
    case TikTok
    
    internal var enumValue: String {
        switch self {
        case .AdService: return "AdService"
        case .Advertising: return "Advertising"
        case .AppsFlyer: return "AppsFlyer"
        case .Link: return "Link"
        case .Persistent: return "Persistent"
        case .Status: return "Status"
        case .Subscription: return "Subscription"
        case .TikTok: return "TikTok"
        }
    }
}

extension AffiseModules: CaseIterable, CustomStringConvertible {
    
    internal func className() -> String { "Affise\(self.enumValue)Module" }

    internal func classNameModule() -> String { "AffiseModule\(self.enumValue).\(self.enumValue)Module" }
    
    internal static func values() -> [AffiseModules] { allCases }
    
    public var description: String { enumValue }
    
    public static func from(_ name: String) -> AffiseModules? {
        return allCases.first { $0.enumValue.contains(name)  }
    }
}
