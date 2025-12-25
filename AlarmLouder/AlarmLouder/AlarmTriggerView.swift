import SwiftUI

struct AlarmTriggerView: View {
    @EnvironmentObject var alarmManager: AlarmManager
    @StateObject private var soundPlayer = AlarmSoundPlayer.shared
    @StateObject private var coinManager = CoinManager.shared
    @State private var currentTime = Date()
    @State private var animationPhase = 0.0
    @State private var showInsufficientCoinsAlert = false

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.red, .orange]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            .hueRotation(.degrees(animationPhase))
            .animation(.easeInOut(duration: 2).repeatForever(autoreverses: true), value: animationPhase)

            VStack(spacing: 40) {
                VStack(spacing: 8) {
                    HStack {
                        Image(systemName: "dollarsign.circle.fill")
                            .font(.title2)
                        Text("\(coinManager.coinBalance) coins")
                            .font(.title2)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(20)
                }
                .padding(.top, 60)

                Spacer()

                VStack(spacing: 16) {
                    Image(systemName: "alarm.fill")
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                        .scaleEffect(1.0 + sin(animationPhase / 50) * 0.1)

                    Text(currentTime, style: .time)
                        .font(.system(size: 72, weight: .thin))
                        .foregroundColor(.white)

                    if let alarm = alarmManager.currentTriggeredAlarm {
                        Text(alarm.label)
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.top, 8)
                    }
                }

                Spacer()

                VStack(spacing: 20) {
                    if alarmManager.currentTriggeredAlarm?.snoozeEnabled == true {
                        Button {
                            if alarmManager.snoozeAlarm() {
                                soundPlayer.stopAlarmSound()
                            } else {
                                showInsufficientCoinsAlert = true
                            }
                        } label: {
                            VStack(spacing: 4) {
                                Text("Snooze")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                Text("Costs \(coinManager.coinsPerSnooze) coins")
                                    .font(.caption)
                                    .fontWeight(.medium)
                            }
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Color.white.opacity(0.3))
                            .cornerRadius(16)
                        }
                    }

                    Button {
                        soundPlayer.stopAlarmSound()
                        alarmManager.dismissAlarm()
                    } label: {
                        Text("Dismiss")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Color.white)
                            .cornerRadius(16)
                    }
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 60)
            }
        }
        .onAppear {
            soundPlayer.playAlarmSound()
            animationPhase = 360
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear {
            soundPlayer.stopAlarmSound()
            UIApplication.shared.isIdleTimerDisabled = false
        }
        .onReceive(timer) { _ in
            currentTime = Date()
        }
        .alert("Insufficient Coins", isPresented: $showInsufficientCoinsAlert) {
            Button("Dismiss Alarm") {
                soundPlayer.stopAlarmSound()
                alarmManager.dismissAlarm()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("You need \(coinManager.coinsPerSnooze) coins to snooze. You have \(coinManager.coinBalance) coins. Purchase more coins from the main screen or dismiss this alarm.")
        }
    }
}

#Preview {
    AlarmTriggerView()
        .environmentObject({
            let manager = AlarmManager()
            manager.currentTriggeredAlarm = Alarm(
                time: Date(),
                label: "Wake Up!",
                snoozeEnabled: true
            )
            manager.isAlarmTriggered = true
            return manager
        }())
}
