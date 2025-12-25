import SwiftUI

struct AddAlarmView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var alarmManager: AlarmManager

    @State private var selectedTime = Date()
    @State private var label = "Alarm"
    @State private var repeatDays: Set<Int> = []
    @State private var snoozeEnabled = true
    @State private var snoozeDuration = 9

    let editingAlarm: Alarm?

    init(editingAlarm: Alarm? = nil) {
        self.editingAlarm = editingAlarm

        if let alarm = editingAlarm {
            _selectedTime = State(initialValue: alarm.time)
            _label = State(initialValue: alarm.label)
            _repeatDays = State(initialValue: alarm.repeatDays)
            _snoozeEnabled = State(initialValue: alarm.snoozeEnabled)
            _snoozeDuration = State(initialValue: alarm.snoozeDuration)
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                }

                Section("Label") {
                    TextField("Alarm", text: $label)
                }

                Section("Repeat") {
                    ForEach(0..<7) { day in
                        RepeatDayRow(day: day, isSelected: repeatDays.contains(day)) {
                            if repeatDays.contains(day) {
                                repeatDays.remove(day)
                            } else {
                                repeatDays.insert(day)
                            }
                        }
                    }
                }

                Section("Snooze") {
                    Toggle("Snooze Enabled", isOn: $snoozeEnabled)

                    if snoozeEnabled {
                        Stepper("Duration: \(snoozeDuration) minutes", value: $snoozeDuration, in: 1...30)
                    }
                }
            }
            .navigationTitle(editingAlarm == nil ? "Add Alarm" : "Edit Alarm")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveAlarm()
                        dismiss()
                    }
                }
            }
        }
    }

    private func saveAlarm() {
        let alarm = Alarm(
            id: editingAlarm?.id ?? UUID(),
            time: selectedTime,
            label: label.isEmpty ? "Alarm" : label,
            isEnabled: true,
            repeatDays: repeatDays,
            snoozeEnabled: snoozeEnabled,
            snoozeDuration: snoozeDuration
        )

        if editingAlarm != nil {
            alarmManager.updateAlarm(alarm)
        } else {
            alarmManager.addAlarm(alarm)
        }
    }
}

struct RepeatDayRow: View {
    let day: Int
    let isSelected: Bool
    let action: () -> Void

    private let dayNames = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(dayNames[day])
                    .foregroundColor(.primary)

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

#Preview {
    AddAlarmView()
        .environmentObject(AlarmManager())
}
