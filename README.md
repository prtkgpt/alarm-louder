# Alarm Louder

A powerful alarm app for heavy sleepers, designed to wake you up with maximum volume and persistence. Features a unique coin-based snooze system to help you resist the temptation to keep sleeping!

## Features

- **Extra Loud Alarms**: Plays alarms at maximum volume to ensure you wake up
- **Coin-Based Snooze System**: Each snooze costs 2,000 coins - a financial incentive to get up!
- **In-App Purchases**: Buy 10,000 coins for $1 to keep snoozing (or run out and be forced to wake up)
- **Custom Alarm Times**: Set multiple alarms for different times
- **Repeat Options**: Configure alarms for specific days of the week
- **Snooze Function**: Customizable snooze duration (1-30 minutes)
- **Persistent Notifications**: Alarms trigger even when the app is closed
- **Vibration Support**: Continuous vibration along with sound
- **Beautiful UI**: Clean, modern SwiftUI interface with coin balance display

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

1. **Purchase Coins**: Tap the coin balance at the top of the main screen to buy coins ($1 = 10,000 coins)
2. **Add an Alarm**: Tap the "+" button to create a new alarm
3. **Set Time**: Use the time picker to select when you want to wake up
4. **Configure**: Set a label, choose repeat days, and configure snooze settings
5. **Enable**: Toggle the alarm on/off from the main list
6. **When it Rings**:
   - **Snooze** (costs 2,000 coins) - Delays the alarm by your configured snooze duration
   - **Dismiss** (free) - Turns off the alarm
7. **Track Your Coins**: Your coin balance is displayed on both the main screen and alarm trigger screen

## Coin System

The coin system creates a financial incentive to help you wake up:

- **Purchase**: $1 = 10,000 coins (5 snoozes worth)
- **Snooze Cost**: 2,000 coins per snooze
- **Run Out**: If you have insufficient coins, you can't snooze and must dismiss the alarm
- **Testing Mode**: If StoreKit products aren't available, use the FREE button to get coins for testing

This system helps heavy sleepers by making each snooze "hurt" financially, encouraging you to get up instead!

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
