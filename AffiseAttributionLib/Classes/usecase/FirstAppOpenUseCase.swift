import Foundation


internal class FirstAppOpenUseCase {
    
    private let FIRST_OPENED = "FIRST_OPENED"
    private let FIRST_OPENED_DATE_KEY = "FIRST_OPENED_DATE_KEY"
    
    private let preferences: UserDefaults
    private var firstRun: Bool = false
    private var isFirstOpenValue: Bool = true
    
    init(
        preferences: UserDefaults
    ) {
        self.preferences = preferences
        isFirstOpenValue = preferences.value(forKey: FIRST_OPENED) as? Bool ?? true
    }

    /**
     * Check preferences for have first opened date and generate properties if no data
     */
    func onAppCreated() {
        if (preferences.value(forKey: FIRST_OPENED_DATE_KEY) == nil) {
            onAppFirstOpen()
        }

        firstRun = preferences.value(forKey: FIRST_OPENED) as? Bool ?? true
    }

    /**
     * Generate properties on app first open
     */
    private func onAppFirstOpen() {
        //Create first open date
        let firstOpenDate = Date().timeIntervalSince1970

        //Save properties
        preferences.set(firstOpenDate, forKey: FIRST_OPENED_DATE_KEY)
        preferences.set(true, forKey: FIRST_OPENED)
    }

    /**
     * Get first open
     * @return is first open
     */
    func isFirstOpen() -> Bool {        
        return isFirstOpenValue
    }

    func completeFirstOpen() {
        isFirstOpenValue = false
        preferences.set(isFirstOpenValue, forKey: FIRST_OPENED)
    }
    
    /**
     * Get first run
     * @return is first run
     */
    func isFirstRun() -> Bool {
        return firstRun
    }

    /**
     * Get first open date
     * @return first open date
     */
    func getFirstOpenDate() -> TimeInterval? {
        guard let value = preferences.value(forKey: FIRST_OPENED_DATE_KEY) as? Double else {
            return nil
        }
        
        return value
    }
}
