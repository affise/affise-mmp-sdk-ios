import Foundation

@objc
internal enum AffiseConfig: Int {
    case FbAppId
    
    var enumValue: String {
        switch self {
        case .FbAppId: return "fb_app_id"
        }
    }
}

extension AffiseConfig: CaseIterable {
    internal static func from(_ name: String?) -> AffiseConfig? {
        guard let name = name else { return nil }
        return allCases.first { name == $0.enumValue }
    }
}
