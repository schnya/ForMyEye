import SwiftUI
import UserNotifications

@main
struct ForMyEyesApp: App {
    init() {
        NotificationManager.requestPermission()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
