import SwiftUI

struct AlarmListView: View {
    @EnvironmentObject var alarmManager: AlarmManager
    @StateObject private var coinManager = CoinManager.shared
    @State private var showingAddAlarm = false
    @State private var showingPurchaseCoins = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Button {
                    showingPurchaseCoins = true
                } label: {
                    HStack {
                        Image(systemName: "dollarsign.circle.fill")
                            .font(.title2)
                            .foregroundColor(.orange)

                        VStack(alignment: .leading, spacing: 2) {
                            Text("\(coinManager.coinBalance) coins")
                                .font(.headline)
                                .foregroundColor(.primary)

                            Text("Snooze costs \(coinManager.coinsPerSnooze) coins")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }

                        Spacer()

                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                }
                .buttonStyle(PlainButtonStyle())

                ZStack {
                    if alarmManager.alarms.isEmpty {
                        VStack(spacing: 20) {
                            Image(systemName: "alarm.fill")
                                .font(.system(size: 80))
                                .foregroundColor(.gray.opacity(0.5))

                            Text("No Alarms")
                                .font(.title2)
                                .foregroundColor(.gray)

                            Text("Tap + to add an alarm")
                                .font(.subheadline)
                                .foregroundColor(.gray.opacity(0.7))
                        }
                    } else {
                        List {
                            ForEach(alarmManager.alarms) { alarm in
                                AlarmRowView(alarm: alarm)
                                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                        Button(role: .destructive) {
                                            alarmManager.deleteAlarm(alarm)
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Alarm Louder")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddAlarm = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.title3)
                    }
                }
            }
            .sheet(isPresented: $showingAddAlarm) {
                AddAlarmView()
            }
            .sheet(isPresented: $showingPurchaseCoins) {
                PurchaseCoinsView()
            }
        }
    }
}

struct AlarmRowView: View {
    @EnvironmentObject var alarmManager: AlarmManager
    let alarm: Alarm
    @State private var showingEditAlarm = false

    var body: some View {
        Button {
            showingEditAlarm = true
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(alarm.timeString)
                        .font(.system(size: 48, weight: .thin))
                        .foregroundColor(alarm.isEnabled ? .primary : .gray)

                    Text(alarm.label)
                        .font(.body)
                        .foregroundColor(alarm.isEnabled ? .primary : .gray)

                    Text(alarm.repeatDescription)
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Spacer()

                Toggle("", isOn: Binding(
                    get: { alarm.isEnabled },
                    set: { _ in alarmManager.toggleAlarm(alarm) }
                ))
                .labelsHidden()
            }
            .padding(.vertical, 8)
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showingEditAlarm) {
            AddAlarmView(editingAlarm: alarm)
        }
    }
}

#Preview {
    AlarmListView()
        .environmentObject(AlarmManager())
}
