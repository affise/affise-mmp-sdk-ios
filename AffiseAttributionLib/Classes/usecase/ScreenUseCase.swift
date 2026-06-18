import Foundation

protocol ScreenUseCase {
    func getScreenWidth() -> Int64

    func getScreenHeight() -> Int64

    func getDensity() -> Double
}
