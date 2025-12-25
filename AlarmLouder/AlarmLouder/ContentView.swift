import SwiftUI

struct ContentView: View {
    @EnvironmentObject var alarmManager: AlarmManager

    var body: some View {
        if alarmManager.isAlarmTriggered {
            AlarmTriggerView()
        } else {
            AlarmListView()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AlarmManager())
}
