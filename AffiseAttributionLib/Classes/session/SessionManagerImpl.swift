import Foundation


struct SessionData {
    let lifetimeSessionCount: TimeInterval
    let affiseSessionCount: Int64
    init(
        lifetimeSessionCount: TimeInterval,
        affiseSessionCount: Int64
    ) {
        self.lifetimeSessionCount = lifetimeSessionCount
        self.affiseSessionCount = affiseSessionCount
    }
}

class SessionManagerImpl {
    
    static let TIME_TO_START_SESSION: TimeInterval = 15

    private let preferences: UserDefaults
    private let appLifecycleEventsManager: AppLifecycleEventsManager
    
    init(
        preferences: UserDefaults,
        appLifecycleEventsManager: AppLifecycleEventsManager
    ) {
        
        self.preferences = preferences
        self.appLifecycleEventsManager = appLifecycleEventsManager
    }

    private lazy var sessionData: SessionData = SessionData(
        lifetimeSessionCount: self.preferences.value(forKey: ProviderType.LIFETIME_SESSION_COUNT.provider) as? TimeInterval ?? 0,
        affiseSessionCount: Int64(self.preferences.integer(forKey: ProviderType.AFFISE_SESSION_COUNT.provider))
    )

    /**
     * Time of start session
     */
    private var openAppTime: TimeInterval? = nil

    /**
     * Last date time of user active
     */
    private var closeAppDateTime: TimeInterval? = nil

    /**
     * Session active status
     */
    private var sessionActive: Bool = false

    /**
     * Open app status
     */
    private var isOpenApp: Bool = false

    /**
     * Subscribe to change open activity count
     */
    private func subscribeToActivityEvents() {
        
        self.startSession()
        
        appLifecycleEventsManager.addDidEnterBackgroundListener { [weak self] userInfo in
            guard let self = self else {
                return
            }
            //Update session status if need
            self.checkSessionToStart()
            
            //Save time of user quit or hide app
            self.closeAppDateTime = Date().timeIntervalSince1970
            
            //App is close
            self.isOpenApp = false
            
            //Drop session status
            self.sessionActive = false
            
            //Save sessionTime
            self.saveSessionTime()
            
            //Drop open app time
            self.openAppTime = nil
        }
        
        appLifecycleEventsManager.addWillEnterForegroundListener { [weak self] userInfo in
            guard let self = self else {
                return
            }
            self.startSession()
        }
    }

    private func startSession() {
        //App is open
        self.isOpenApp = true
        
        /**
         * Check create open app time
         */
        if (self.openAppTime == nil) {
            //open app time
            self.openAppTime = self.currentTime()
        }

        delayRun(delay: SessionManagerImpl.TIME_TO_START_SESSION) {
            if self.sessionTime() > 0 {
                var count = self.getSessionCount();
                if count == 0 {
                    count = 1
                }

                //Send sdk events
                SessionStartInternalEvent(
                    affiseSessionCount: count,
                    lifetimeSessionCount: self.getLifetimeSessionTime().timeInMillis
                )
                .send()
            }
        }
    }

    /**
     * Check time of start app and start session
     */
    private func checkSessionToStart() {
        if sessionActive {
            return
        }
        
        //if session started
        if (sessionTime() > 0) {
            sessionActive = true
            
            //Save new session
            addNewSession()
        }
    }

     private func sessionTime() -> TimeInterval {
        if sessionActive {
            return 0
        }

        //Check open app time
        if let startTime = openAppTime {
            //Time current session
            let time = currentTime() - startTime - SessionManagerImpl.TIME_TO_START_SESSION
            
            //if session started
            if (time > 0) {
                return time
            }
        }
        return 0
     }

    /**
     * Save session time
     */
    private func saveSessionTime() {
        let lifetimeSessionTime = getLifetimeSessionTime()

        sessionData = sessionData.copy(lifetimeSessionCount: lifetimeSessionTime)

        preferences.set(lifetimeSessionTime, forKey: ProviderType.LIFETIME_SESSION_COUNT.provider)
    }

    /**
     * Get all old sessions time
     */
    private func getSaveSessionsTime() -> TimeInterval {
        sessionData.lifetimeSessionCount
    }

    /**
     * Save new session count
     */
    private func addNewSession() {
        let count = sessionData.affiseSessionCount + 1

        sessionData = sessionData.copy(affiseSessionCount: count)

        preferences.set(count, forKey: ProviderType.AFFISE_SESSION_COUNT.provider)
    }

    /**
     * Current time in seconds since Unix epoch.
     */
    private func currentTime() -> TimeInterval {
        return Date().timeIntervalSince1970
    }
}


extension SessionManagerImpl: SessionManager {
    
    func initialize() {
        subscribeToActivityEvents()
    }

    func sessionStart() {
        startSession()
    }
    
    func isSessionActive() -> Bool {
        //Check session status
        checkSessionToStart()
        
        //Return session status
        return sessionActive
    }
    
    func getLastInteractionTime() -> TimeInterval? {
        //Current time if app is open
        if (isOpenApp) {
            return Date().timeIntervalSince1970
        } else {
            //lastInteractionTime is session is active
            return closeAppDateTime
        }
    }
    
    func getSessionTime() -> TimeInterval {
        if let startTime = openAppTime{
            return currentTime() - startTime
        } else {
            return 0
        }
    }
    
    func getLifetimeSessionTime() -> TimeInterval {
        return getSaveSessionsTime() + getSessionTime()
    }
    
    func getSessionCount() -> Int64 {
        //Check session status
        if (!sessionActive) {
            checkSessionToStart()
        }

        return sessionData.affiseSessionCount
    }
}

extension SessionData {
    
    func copy(lifetimeSessionCount: TimeInterval? = nil, affiseSessionCount: Int64? = nil) -> SessionData {
        let copy = self
        if let value = lifetimeSessionCount {
            return SessionData(
                lifetimeSessionCount: value,
                affiseSessionCount: self.affiseSessionCount
            )
        }
        if let value = affiseSessionCount {
            return SessionData(
                lifetimeSessionCount: self.lifetimeSessionCount,
                affiseSessionCount: value
            )
        }
        return copy
    }
}
