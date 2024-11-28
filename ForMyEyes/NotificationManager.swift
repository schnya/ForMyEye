import SwiftUI

class NotificationManager: ObservableObject {
    var resetInterval: Int
    init(resetInterval: Int) {
        self.resetInterval = resetInterval
    }

    static func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("通知の許可エラー: \(error.localizedDescription)")
            }
            print("通知の許可: \(granted ? "許可済み" : "拒否")")
        }
    }

    func handleUsageTimeExceeded(_ usageTime: Int) {
        switch usageTime {
        case 600:
            sendNotification(title: "スマホ使いすぎ！", body: "10分以上使用しています。少し休憩しましょう。")
        case 1200:
            sendNotification(title: "スマホ使いすぎ！", body: "20分以上使用しています。少し休憩しましょう。")
        case resetInterval:
            sendNotification(title: "はい、リセット", body: "寝れるとき寝えや、まじで")
        default:
            break
        }
    }

    func sendNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("通知スケジュールエラー: \(error.localizedDescription)")
            } else {
                print("通知スケジュール完了: \(title)")
            }
        }
    }

    static func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        print("全ての通知をキャンセルしました")
    }
}
