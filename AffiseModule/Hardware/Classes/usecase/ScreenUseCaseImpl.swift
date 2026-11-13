import UIKit

internal class ScreenUseCaseImpl: ScreenUseCase {

    func getScreenWidth() -> Int64 {
        let screen = UIScreen.main
        return Int64(screen.bounds.width * screen.scale)
    }

    func getScreenHeight() -> Int64 {
        let screen = UIScreen.main
        return Int64(screen.bounds.height * screen.scale)
    }

    func getDensity() -> Double {
        return UIScreen.main.scale
    }
}
