import SwiftUI
import UserNotifications

@main
struct AlarmLouderApp: App {
    @StateObject private var alarmManager = AlarmManager()
    @Environment(\.scenePhase) private var scenePhase

    init() {
        requestNotificationPermissions()
        configureAudioSession()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(alarmManager)
                .onChange(of: scenePhase) { newPhase in
                    if newPhase == .active {
                        alarmManager.checkForTriggeredAlarms()
                    }
                }
        }
    }

    private func requestNotificationPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permissions granted")
            } else if let error = error {
                print("Error requesting notification permissions: \(error.localizedDescription)")
            }
        }
    }

    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to configure audio session: \(error)")
        }
    }
}
