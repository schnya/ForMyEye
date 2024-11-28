import SwiftUI

class TimerManager: ObservableObject {
    @Published var usageTime = 0
    @Published var isRunning = false
    @Published var isScreenOff = false
    @Published var timer: Timer? = nil

    var resetInterval: Int
    let startTimeKey = "timerStartTime"
    let backgroundTimeKey = "backgroundTime"

    var onUsageTimeExceeded: ((Int) -> Void)?

    init(resetInterval: Int) {
        self.resetInterval = resetInterval
    }

    func initialize() {
        if let savedStartTime = UserDefaults.standard.object(forKey: startTimeKey) as? Date {
            let elapsedTime = Int(Date().timeIntervalSince(savedStartTime))
            usageTime = elapsedTime
            isRunning = true
            start()
        } else {
            usageTime = 0 // タイマーリセット状態
            isRunning = false
        }
        NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main) { _ in
            let currentDate = Date()
            UserDefaults.standard.set(currentDate, forKey: self.backgroundTimeKey)
        }
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { _ in
            if let backgroundTime = UserDefaults.standard.object(forKey: self.backgroundTimeKey) as? Date {
                let elapsedTime = Int(Date().timeIntervalSince(backgroundTime))
                if self.isRunning {
                    self.usageTime += elapsedTime
                }
            }
        }
        startBrightnessMonitoring()
    }

    func toggle() {
        isRunning.toggle() // タイマーをスタート/ストップ
        if isRunning {
            let currentDate = Date()
            UserDefaults.standard.set(currentDate, forKey: startTimeKey)
        } else {
            UserDefaults.standard.removeObject(forKey: startTimeKey)
        }
    }

    func start() {
        pause() // 既存のタイマーを停止（重複防止）
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.isRunning && !self.isScreenOff {
                self.tick()
            }
        }
    }

    func pause() {
        timer?.invalidate()
        timer = nil
    }

    func stop() {
        usageTime = 0
        isRunning = false
        NotificationManager.cancelAllNotifications()
    }

    private func tick() {
        usageTime += 1
        if let callback = onUsageTimeExceeded {
            callback(usageTime)
        }
    }

    // スリープ状態を監視
    func startBrightnessMonitoring() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if UIScreen.main.brightness == 0 {
                if !self.isScreenOff {
                    self.isScreenOff = true
                    self.usageTime = 0
                    self.pause()
                }
            } else {
                if self.isScreenOff {
                    self.isScreenOff = false
                    print("デバイスがスリープ状態から復帰しました")
                    if self.isRunning { // スリープ復帰時にタイマーを再開
                        self.start()
                    }
                }
            }
        }
    }
}
