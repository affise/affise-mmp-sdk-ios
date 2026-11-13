import UIKit

internal class VendorUseCaseImpl: VendorUseCase {
    func getIdentifierForVendor() -> String? {
        return UIDevice.current.identifierForVendor?.uuidString
    }
}
