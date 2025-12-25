import Foundation
import UserNotifications
import Combine

class AlarmManager: ObservableObject {
    @Published var alarms: [Alarm] = []
    @Published var isAlarmTriggered: Bool = false
    @Published var currentTriggeredAlarm: Alarm?

    private let userDefaults = UserDefaults.standard
    private let alarmsKey = "SavedAlarms"

    init() {
        loadAlarms()
        setupNotificationDelegate()
    }

    func loadAlarms() {
        if let data = userDefaults.data(forKey: alarmsKey),
           let decoded = try? JSONDecoder().decode([Alarm].self, from: data) {
            alarms = decoded
        }
    }

    func saveAlarms() {
        if let encoded = try? JSONEncoder().encode(alarms) {
            userDefaults.set(encoded, forKey: alarmsKey)
        }
    }

    func addAlarm(_ alarm: Alarm) {
        alarms.append(alarm)
        saveAlarms()
        if alarm.isEnabled {
            scheduleNotification(for: alarm)
        }
    }

    func updateAlarm(_ alarm: Alarm) {
        if let index = alarms.firstIndex(where: { $0.id == alarm.id }) {
            alarms[index] = alarm
            saveAlarms()
            cancelNotification(for: alarm)
            if alarm.isEnabled {
                scheduleNotification(for: alarm)
            }
        }
    }

    func deleteAlarm(_ alarm: Alarm) {
        alarms.removeAll { $0.id == alarm.id }
        saveAlarms()
        cancelNotification(for: alarm)
    }

    func toggleAlarm(_ alarm: Alarm) {
        if let index = alarms.firstIndex(where: { $0.id == alarm.id }) {
            alarms[index].isEnabled.toggle()
            saveAlarms()

            if alarms[index].isEnabled {
                scheduleNotification(for: alarms[index])
            } else {
                cancelNotification(for: alarms[index])
            }
        }
    }

    func scheduleNotification(for alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.body = alarm.label
        content.sound = UNNotificationSound(named: UNNotificationSoundName("alarm_sound.mp3"))
        content.categoryIdentifier = "ALARM_CATEGORY"

        let calendar = Calendar.current
        var dateComponents = calendar.dateComponents([.hour, .minute], from: alarm.time)

        if alarm.repeatDays.isEmpty {
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let request = UNNotificationRequest(identifier: alarm.id.uuidString, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                }
            }
        } else {
            for day in alarm.repeatDays {
                dateComponents.weekday = day + 1
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
                let identifier = "\(alarm.id.uuidString)-\(day)"
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

                UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Error scheduling notification: \(error)")
                    }
                }
            }
        }
    }

    func cancelNotification(for alarm: Alarm) {
        var identifiers = [alarm.id.uuidString]

        for day in 0..<7 {
            identifiers.append("\(alarm.id.uuidString)-\(day)")
        }

        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
    }

    func checkForTriggeredAlarms() {
        let now = Date()
        let calendar = Calendar.current

        for alarm in alarms where alarm.isEnabled {
            let alarmComponents = calendar.dateComponents([.hour, .minute], from: alarm.time)
            let nowComponents = calendar.dateComponents([.hour, .minute], from: now)

            if alarmComponents.hour == nowComponents.hour &&
               alarmComponents.minute == nowComponents.minute {

                let weekday = calendar.component(.weekday, from: now) - 1

                if alarm.repeatDays.isEmpty || alarm.repeatDays.contains(weekday) {
                    triggerAlarm(alarm)
                    break
                }
            }
        }
    }

    func triggerAlarm(_ alarm: Alarm) {
        currentTriggeredAlarm = alarm
        isAlarmTriggered = true
    }

    func snoozeAlarm() {
        guard let alarm = currentTriggeredAlarm, alarm.snoozeEnabled else { return }

        let snoozeTime = Date().addingTimeInterval(TimeInterval(alarm.snoozeDuration * 60))
        var snoozeAlarm = alarm
        snoozeAlarm.id = UUID()
        snoozeAlarm.time = snoozeTime
        snoozeAlarm.repeatDays = []
        snoozeAlarm.label = "\(alarm.label) (Snoozed)"

        addAlarm(snoozeAlarm)
        dismissAlarm()
    }

    func dismissAlarm() {
        isAlarmTriggered = false
        currentTriggeredAlarm = nil
    }

    private func setupNotificationDelegate() {
        UNUserNotificationCenter.current().delegate = NotificationDelegate.shared
        NotificationDelegate.shared.alarmManager = self
    }
}

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationDelegate()
    weak var alarmManager: AlarmManager?

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        if let alarmIdString = notification.request.identifier.components(separatedBy: "-").first,
           let alarmId = UUID(uuidString: alarmIdString),
           let alarm = alarmManager?.alarms.first(where: { $0.id == alarmId }) {
            alarmManager?.triggerAlarm(alarm)
        }

        completionHandler([.banner, .sound, .badge])
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        if let alarmIdString = response.notification.request.identifier.components(separatedBy: "-").first,
           let alarmId = UUID(uuidString: alarmIdString),
           let alarm = alarmManager?.alarms.first(where: { $0.id == alarmId }) {
            alarmManager?.triggerAlarm(alarm)
        }

        completionHandler()
    }
}
