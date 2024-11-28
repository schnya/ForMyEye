import SwiftUI

struct ContentView: View {
    @StateObject private var timer: TimerManager
    @StateObject private var notifier: NotificationManager

    init() {
        _timer = StateObject(wrappedValue: TimerManager(resetInterval: 1220))
        _notifier = StateObject(wrappedValue: NotificationManager(resetInterval: 1220))
    }

    var body: some View {
        VStack {
            Text("使用時間: \(timer.usageTime) 秒")
                .font(.largeTitle)
                .padding()

            Button(action: timer.toggle) {
                Text(timer.isRunning ? "Pause" : "開始")
                    .padding()
                    .background(timer.isRunning ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            Button(action: timer.stop) {
                Text("Stop")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .onAppear {
            timer.initialize()
            timer.onUsageTimeExceeded = { usageTime in
                notifier.handleUsageTimeExceeded(usageTime)
            }
        }
    }
}

#Preview {
    ContentView()
}
