import Foundation
import AffiseAttributionLib
import GoogleAdsOnDeviceConversion


class GoogleOdmUseCaseImpl: GoogleOdmUseCase {

    private let firstAppOpenUseCase: FirstAppOpenUseCase
    private let lockQueue = DispatchQueue(label: "com.affise.google.odm", attributes: .concurrent)
    private var odmInfo: String?

    init(firstAppOpenUseCase: FirstAppOpenUseCase) {
        self.firstAppOpenUseCase = firstAppOpenUseCase
    }

    func initialize() {
        guard let firstOpenDate = firstAppOpenUseCase.getFirstOpenDate() else {
            return
        }

        ConversionManager.sharedInstance.setFirstLaunchTime(Date(timeIntervalSince1970: firstOpenDate))
        ConversionManager.sharedInstance.fetchAggregateConversionInfo(for: .installation) { [weak self] aggregateConversionInfo, error in
            guard error == nil else {
                debugPrint("ODM error: \(error?.localizedDescription)")
                return
            }
            
            self?.lockQueue.async(flags: .barrier) {
                self?.odmInfo = aggregateConversionInfo
            }
        }
    }

    func getOdmInfo() -> String? {
        lockQueue.sync {
            odmInfo
        }
    }
}
