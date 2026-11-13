internal class EmulatorUseCaseImpl: EmulatorUseCase {
    func isEmulator() -> Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
}
