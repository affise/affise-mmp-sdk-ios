import Foundation

protocol GoogleOdmUseCase {

    func initialize()

    func getOdmInfo() -> String?
}
