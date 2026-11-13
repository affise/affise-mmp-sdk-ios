import CoreTelephony

protocol NetworkInfoUseCase {
    func firstCarrier() -> CTCarrier?
}
