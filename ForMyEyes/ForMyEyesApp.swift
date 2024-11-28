//
//  ForMyEyesApp.swift
//  ForMyEyes
//
//  Created by 浅野竣弥 on 2024/11/28.
//

import SwiftUI
import UserNotifications

@main
struct ForMyEyesApp: App {
    init() {
        configureNotificationDelegate()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    func configureNotificationDelegate() {
        let center = UNUserNotificationCenter.current()
        center.delegate = NotificationDelegate() // デリゲートを設定
        requestNotificationPermission()
    }

    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        if let error = error {
            print("通知の許可エラー: \(error.localizedDescription)")
        }
        print("通知の許可: \(granted ? "許可済み" : "拒否")")
    }
    }
}

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound]) // フォアグラウンドで通知を表示
    }
}
