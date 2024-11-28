import SwiftUI
import UserNotifications

@main
struct ForMyEyesApp: App {
    init() {
        NotificationManager.shared.requestPermission()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
