import CoreTelephony


internal class NetworkInfoUseCaseImpl {

    private let carrier: CTCarrier?

    init() {
        let networkInfo = CTTelephonyNetworkInfo()
        self.carrier = networkInfo.serviceSubscriberCellularProviders?.first?.value
    }
}

extension NetworkInfoUseCaseImpl: NetworkInfoUseCase {

    func firstCarrier() -> CTCarrier? {
        return carrier
    }
}
