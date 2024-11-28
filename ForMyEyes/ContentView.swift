import SwiftUI

struct ContentView: View {
    @State private var usageTime = 0
    @State private var isRunning = false
    @State private var isScreenOff = false // スリープ状態かどうか
    @State private var timer: Timer? = nil // 現在のタイマー

    let startTimeKey = "timerStartTime" // UserDefaults用のキー
    let backgroundTimeKey = "backgroundTime" // バックグラウンド移行時の時刻保存用のキー
    let resetInterval = 122 // 20分20秒（秒単位）

    var body: some View {
        VStack {
            Text("使用時間: \(usageTime) 秒")
                .font(.largeTitle)
                .padding()

            Button(action: {
                isRunning.toggle() // タイマーをスタート/ストップ
                if isRunning {
                    saveStartTime() // タイマー開始時刻を保存
                } else {
                    resetStartTime() // タイマー停止時に開始時刻をリセット
                }
            }) {
                Text(isRunning ? "停止" : "開始")
                    .padding()
                    .background(isRunning ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            // リセットボタン
            Button(action: {
                resetState()
            }) {
                Text("リセット")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .onAppear {
            loadUsageTime() // 起動時に経過時間を計算
            startTimer()
            NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main) { _ in
                saveBackgroundTime()
            }
            NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { _ in
                updateTimeFromBackground()
            }
            startBrightnessMonitoring()
        }
    }

    // タイマー関数
    func startTimer() {
        print("タイマーを開始します")
        stopTimer() // 既存のタイマーを停止（重複防止）
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if isRunning && !isScreenOff {
                usageTime += 1
                if usageTime == 6 {
                    NotificationManager.shared.sendNotification(
                        title: "スマホ使いすぎ！",
                        body: "10分以上使用しています。少し休憩しましょう。"
                    )
                } else if usageTime == 120 {
                    NotificationManager.shared.sendNotification(
                        title: "スマホ使いすぎ！",
                        body: "20分以上使用しています。少し休憩しましょう。"
                    )
                } else if usageTime >= resetInterval {
                    NotificationManager.shared.sendNotification(
                        title: "はい、リセット",
                        body: "寝れるとき寝えや、まじで"
                    )
                    usageTime = 0
                }
            }
        }
    }

    // タイマーを停止
    func stopTimer() {
        print("タイマーを停止します")
        timer?.invalidate()
        timer = nil
    }

    // タイマー開始時刻を保存
    func saveStartTime() {
        let currentDate = Date()
        UserDefaults.standard.set(currentDate, forKey: startTimeKey)
    }

    // タイマー開始時刻を削除（リセット）
    func resetStartTime() {
        UserDefaults.standard.removeObject(forKey: startTimeKey)
    }

    // 状態をリセット
    func resetState() {
        print("リセット処理実行")
        usageTime = 0 // 使用時間をリセット
        isRunning = false // タイマーを停止
        NotificationManager.shared.cancelAllNotifications()
    }

    // 使用時間をリセット
    func resetUsageTime() {
        print("使用時間をリセットします")
        usageTime = 0
        stopTimer()
    }

    // アプリ起動時に経過時間を計算
    func loadUsageTime() {
        if let savedStartTime = UserDefaults.standard.object(forKey: startTimeKey) as? Date {
            let elapsedTime = Int(Date().timeIntervalSince(savedStartTime))
            usageTime = elapsedTime
            isRunning = true // 再開状態にする
        } else {
            usageTime = 0 // タイマーリセット状態
            isRunning = false
        }
    }

    func saveBackgroundTime() {
        let currentDate = Date()
        UserDefaults.standard.set(currentDate, forKey: backgroundTimeKey)
    }

    func updateTimeFromBackground() {
        if let backgroundTime = UserDefaults.standard.object(forKey: backgroundTimeKey) as? Date {
            let elapsedTime = Int(Date().timeIntervalSince(backgroundTime))
            if isRunning {
                usageTime += elapsedTime
            }
        }
    }

    // スリープ状態を監視
    func startBrightnessMonitoring() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if UIScreen.main.brightness == 0 {
                if !isScreenOff {
                    isScreenOff = true
                    print("デバイスがスリープ状態になりました")
                    resetUsageTime()
                }
            } else {
                if isScreenOff {
                    isScreenOff = false
                    print("デバイスがスリープ状態から復帰しました")
                    if isRunning { // スリープ復帰時にタイマーを再開
                        startTimer()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
