import Foundation

struct Alarm: Identifiable, Codable {
    var id: UUID
    var time: Date
    var label: String
    var isEnabled: Bool
    var repeatDays: Set<Int>
    var snoozeEnabled: Bool
    var snoozeDuration: Int

    init(
        id: UUID = UUID(),
        time: Date = Date(),
        label: String = "Alarm",
        isEnabled: Bool = true,
        repeatDays: Set<Int> = [],
        snoozeEnabled: Bool = true,
        snoozeDuration: Int = 9
    ) {
        self.id = id
        self.time = time
        self.label = label
        self.isEnabled = isEnabled
        self.repeatDays = repeatDays
        self.snoozeEnabled = snoozeEnabled
        self.snoozeDuration = snoozeDuration
    }

    var timeString: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: time)
    }

    var repeatDescription: String {
        if repeatDays.isEmpty {
            return "One time"
        }

        let dayNames = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        let sortedDays = repeatDays.sorted()

        if sortedDays.count == 7 {
            return "Every day"
        } else if sortedDays == [1, 2, 3, 4, 5] {
            return "Weekdays"
        } else if sortedDays == [0, 6] {
            return "Weekends"
        } else {
            return sortedDays.map { dayNames[$0] }.joined(separator: ", ")
        }
    }
}
