import Foundation

public enum AffiseError: Error {
    case cloud(url: String, error: Error, attempts: Int, retry: Bool)
    case network(status: Int, message: String?)
    case offlineModeEnabled
    case trackingDisabledException
    case backgroundTrackingDisabledException
    case alreadyInitialized
    
    static let ALREADY_INITIALIZED = "Affise SDK is already initialized"
    internal static let NOT_INITIALIZED = "Affise SDK is not initialized"
    internal static let ERROR_READING_FROM_PREFERENCES = "error_reading_from_preferences"
    static let UUID_NOT_INITIALIZED = "11111111-1111-1111-1111-111111111111"
    static let UUID_NO_VALID_METHOD = "22222222-2222-2222-2222-222222222222"
}

extension AffiseError : LocalizedError {

    private var localized: String? {
        switch self {
        case .cloud(url: let url, error: let error, attempts: let attempts, retry: let retry):
            return NSLocalizedString(#"AffiseError.cloud(url=\#(url), error=\#(error.localizedDescription), attempts=\#(attempts), retry=\#(retry))"#, comment: "")
        case .network(status: let status, message: let message):
            return NSLocalizedString(#"AffiseError.network(status=\#(status), message=\#(message ?? ""))"#, comment: "")
        case .offlineModeEnabled:
            return NSLocalizedString("AffiseError.offlineModeEnabled", comment: "")
        case .trackingDisabledException:
            return NSLocalizedString("AffiseError.trackingDisabledException", comment: "")
        case .backgroundTrackingDisabledException:
            return NSLocalizedString("AffiseError.backgroundTrackingDisabledException", comment: "")
        case .alreadyInitialized:
            return NSLocalizedString(AffiseError.ALREADY_INITIALIZED, comment: "")
        }
    }

    public var errorDescription: String? {
        switch self {
        case .alreadyInitialized:
            return localized
        default:
            return localized?.toJsonGuardString()
        }
    }
}
