# Alarm Louder

A powerful alarm app for heavy sleepers, designed to wake you up with maximum volume and persistence.

## Features

- **Extra Loud Alarms**: Plays alarms at maximum volume to ensure you wake up
- **Custom Alarm Times**: Set multiple alarms for different times
- **Repeat Options**: Configure alarms for specific days of the week
- **Snooze Function**: Customizable snooze duration (1-30 minutes)
- **Persistent Notifications**: Alarms trigger even when the app is closed
- **Vibration Support**: Continuous vibration along with sound
- **Beautiful UI**: Clean, modern SwiftUI interface

## Requirements

- iOS 16.0 or later
- Xcode 14.0 or later
- Swift 5.0 or later

## Setup Instructions

1. Open `AlarmLouder.xcodeproj` in Xcode
2. Add an alarm sound file named `alarm_sound.mp3` to the project (place it in `AlarmLouder/AlarmLouder/`)
3. Select a development team in the project settings
4. Build and run on a physical device (recommended for testing alarm sounds)

## Usage

1. **Add an Alarm**: Tap the "+" button to create a new alarm
2. **Set Time**: Use the time picker to select when you want to wake up
3. **Configure**: Set a label, choose repeat days, and configure snooze settings
4. **Enable**: Toggle the alarm on/off from the main list
5. **When it Rings**: Dismiss or snooze the alarm when it goes off

## Important Notes

- For best results, test the app on a physical iOS device
- Grant notification permissions when prompted
- Keep your device volume at maximum for the loudest alarm
- The app uses background audio mode to ensure alarms trigger reliably

## Background Audio

The app is configured with background audio capabilities to ensure alarms can play even when the app is not in the foreground. Notifications are also used as a backup mechanism.

## Customization

You can customize the alarm sound by replacing `alarm_sound.mp3` with your own audio file. For the loudest effect, use an audio file with:
- High volume normalization
- Sharp, attention-grabbing tones
- MP3 format for compatibility

## License

This project is provided as-is for personal use and modification.
