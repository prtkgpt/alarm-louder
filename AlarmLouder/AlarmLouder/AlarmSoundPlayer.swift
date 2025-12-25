import AVFoundation
import UIKit

class AlarmSoundPlayer: ObservableObject {
    static let shared = AlarmSoundPlayer()

    private var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false

    private init() {
        setupAudioSession()
    }

    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(
                .playback,
                mode: .default,
                options: [.duckOthers]
            )
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to setup audio session: \(error)")
        }
    }

    func playAlarmSound() {
        guard let soundURL = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else {
            print("Could not find alarm sound file")
            playSystemSound()
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.volume = 1.0

            setMaximumVolume()

            audioPlayer?.play()
            isPlaying = true

            startVibration()

        } catch {
            print("Could not play alarm sound: \(error)")
            playSystemSound()
        }
    }

    func stopAlarmSound() {
        audioPlayer?.stop()
        audioPlayer = nil
        isPlaying = false
        stopVibration()
    }

    private func setMaximumVolume() {
        do {
            try AVAudioSession.sharedInstance().setCategory(
                .playback,
                mode: .default,
                options: []
            )
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set maximum volume: \(error)")
        }
    }

    private func playSystemSound() {
        guard let soundURL = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else {
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.volume = 1.0
            audioPlayer?.play()
            isPlaying = true
        } catch {
            print("Failed to play system sound: \(error)")
        }
    }

    private var vibrationTimer: Timer?

    private func startVibration() {
        vibrationTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
    }

    private func stopVibration() {
        vibrationTimer?.invalidate()
        vibrationTimer = nil
    }
}
