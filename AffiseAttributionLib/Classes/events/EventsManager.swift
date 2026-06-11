import Foundation

/**
 * Manager of Events
 *
 * @property sendDataToServerUseCase the use case sending data to server.
 * @property activityCountProvider the provider observe count of open activity
 */
class EventsManager {
    
    static let TIME_SEND_SECOND: TimeInterval = 3
    static let TIME_SEND_REPEAT: TimeInterval = 15
    
    static let SCHEDULER_SEND_REPEAT: TimeInterval = 15
    
    private let sendDataToServerUseCase: SendDataToServerUseCase
    private let appLifecycleEventsManager: AppLifecycleEventsManager

    init(
        sendDataToServerUseCase: SendDataToServerUseCase,
        appLifecycleEventsManager: AppLifecycleEventsManager
    ) {
        
        self.sendDataToServerUseCase = sendDataToServerUseCase
        self.appLifecycleEventsManager = appLifecycleEventsManager
    }
    
    func initialize() throws {
        subscribeToActivityEvents()
        sendEventsOnStop()
    }
    
    /**
     * Last session count
     */
    private var lastSessionCount = 0

    /**
     * Timer fo repeat send events
     */
    private var timer: ScheduledTimer?
    private var timerSecond: ScheduledTimer?
    
    private var scheduler: ScheduledTimer?

    private func sendEventsOnStop() {
        appLifecycleEventsManager.addDidEnterBackgroundListener { [weak self] userInfo in
            self?.sendEvents(withDelay: false, sendEmpty: false)
        }
    }

    /**
     * Subscribe to change activity
     */
    private func subscribeToActivityEvents() {
        //Send events on started
        sendEvents(withDelay: false)

        //Send events on delay
        sendEventsDelay(delay: EventsManager.TIME_SEND_SECOND)
        
        //Start timer fo repeat send events
        startTimer()
        
        //Start scheduler
        startQueue()
        
        appLifecycleEventsManager.addDidEnterBackgroundListener { [weak self] userInfo in
            //Stop timer
            self?.stopTimer()
            
            //Stop scheduler
            self?.stopQueue()
        }
        
        appLifecycleEventsManager.addWillEnterForegroundListener { [weak self] userInfo in
            //Send events on started
            self?.sendEvents(withDelay: false)
            
            //Start timer fo repeat send events
            self?.startTimer()
            
            //Start scheduler
            self?.startQueue()
        }
    }

    /**
     * Send event
     */
    func sendEvents(withDelay: Bool = true, sendEmpty: Bool = true) {
        DispatchQueue.global(qos:.background).sync {
            sendDataToServerUseCase.send(withDelay: withDelay, sendEmpty: sendEmpty)
        }
    }

    private func sendEventsDelay(delay: TimeInterval) { 
        timerSecond?.stop()
        timerSecond = ScheduledTimer(interval: delay, repeats: false) { [weak self] in
            self?.sendEvents(withDelay: false)
        }
    }
    
    /**
     * Send events (if present) on schedule in case network failures
     */
    private func startQueue() {
        scheduler?.stop()
        scheduler = ScheduledTimer(interval: EventsManager.SCHEDULER_SEND_REPEAT, repeats: true) { [weak self] in
            self?.sendEvents(withDelay: false, sendEmpty: false)
        }
    }
    
    private func stopQueue() {
        scheduler?.stop()
    }

    /**
     * Start timer fo repeat send events
     */
    private func startTimer() {
        //Stop timer if running
        timer?.stop()
        //Create timer
        timer = ScheduledTimer(interval: EventsManager.TIME_SEND_REPEAT, repeats: true) { [weak self] in
            self?.fireTimer()
        }
    }

    /**
     * Stop timer fo repeat send events
     */
    private func stopTimer() {
        //Stop timer
        timer?.stop()

        //Stop second timer
        timerSecond?.stop()
    }

    @objc
    private func fireTimer() {
        //Send events
        sendEvents()

        //Stop timer
        stopTimer()
    }
}
