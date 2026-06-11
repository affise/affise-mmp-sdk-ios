import Foundation

public protocol FirstAppOpenUseCase {
    func onAppCreated()
    func isFirstOpen() -> Bool
    func completeFirstOpen()
    func isFirstRun() -> Bool
    func getFirstOpenDate() -> TimeInterval?
}
