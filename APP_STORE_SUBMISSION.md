# App Store Submission Guide - Alarm Louder

## Required Assets

### App Icon
- Create app icon in all required sizes (in Assets.xcassets/AppIcon.appiconset/)
- Sizes needed: 1024x1024 (App Store), 180x180, 120x120, 87x87, 80x80, 76x76, etc.
- Design tip: Use alarm clock or coin imagery

### Screenshots (Required for App Store)
- iPhone 6.7" (iPhone 14 Pro Max): 1290 x 2796 pixels (at least 3)
- iPhone 6.5" (iPhone 11 Pro Max): 1242 x 2688 pixels
- iPhone 5.5" (iPhone 8 Plus): 1242 x 2208 pixels
- Take screenshots of:
  1. Main alarm list with coin balance
  2. Add alarm screen
  3. Alarm trigger screen showing coin cost
  4. Purchase coins screen

### Alarm Sound
- Add your alarm_sound.mp3 file (currently missing)
- Must be loud and attention-grabbing
- Recommended: 30 seconds minimum, loops automatically

## App Store Connect Configuration

### 1. Create App in App Store Connect
- Go to: https://appstoreconnect.apple.com
- Click "My Apps" → "+" → "New App"
- Bundle ID: com.alarmlouder.app (match your Xcode project)
- SKU: ALARM_LOUDER_001
- Primary Language: English

### 2. Configure In-App Purchase
⚠️ CRITICAL: Set up BEFORE submitting app

Go to App Store Connect → Your App → Features → In-App Purchases:
- Click "+" to create new In-App Purchase
- Type: Consumable
- Reference Name: "10,000 Coins"
- Product ID: com.alarmlouder.coins10000 (must match CoinManager.swift)
- Price: $0.99 (Tier 1)
- Localization (English):
  - Display Name: "10,000 Coins"
  - Description: "Purchase 10,000 coins to use for snoozing alarms. Each snooze costs 2,000 coins."
- Screenshot: Optional but recommended (show purchase screen)

### 3. App Information
- **App Name**: Alarm Louder
- **Subtitle**: Wake Up With Financial Consequences
- **Category**: Productivity or Lifestyle
- **Description**: See template below
- **Keywords**: alarm,loud,wake up,heavy sleeper,snooze,coins,productivity
- **Support URL**: Your website or GitHub repo
- **Privacy Policy URL**: Required (see template below)

## Xcode Configuration

### Update Info.plist Permissions
Add these keys with descriptions:
- NSUserNotificationsUsageDescription: "Allows alarms to trigger even when app is closed"
- UIBackgroundModes: Already has "audio" ✓

### Update Build Settings
1. Open project in Xcode
2. Select AlarmLouder target
3. Signing & Capabilities:
   - Team: Select your Apple Developer team
   - Bundle Identifier: com.alarmlouder.app (or your unique ID)
   - Signing: Automatic
   - Add Capability: "In-App Purchase" (if not present)

4. General:
   - Version: 1.0
   - Build: 1
   - Deployment Target: iOS 16.0

### Configure StoreKit Testing
1. In Xcode: Product → Scheme → Edit Scheme
2. Run → Options → StoreKit Configuration
3. Select Products.storekit ✓ (already created)

## Build and Archive

### 1. Update Product ID in App Store Connect
- Copy the exact Product ID from App Store Connect
- Update CoinManager.swift if different:
  ```swift
  private let coinProductID = "com.alarmlouder.coins10000"
  ```

### 2. Archive the App
```bash
# In Xcode:
1. Select "Any iOS Device" as destination (not simulator)
2. Product → Archive
3. Wait for archive to complete
4. Organizer window opens automatically
```

### 3. Upload to App Store
```bash
# In Organizer:
1. Click "Distribute App"
2. Select "App Store Connect"
3. Click "Upload"
4. Select signing: "Automatically manage signing"
5. Review app info
6. Click "Upload"
7. Wait for processing (10-60 minutes)
```

## App Store Submission

### 1. Fill Out App Information
- Age Rating: 4+ (no objectionable content)
- Price: Free (with in-app purchases)
- Availability: All countries

### 2. Submit for Review
- Add your screenshots
- Add app description (see below)
- Add privacy policy
- Select your build
- Answer review questions honestly
- Submit!

### 3. Review Notes for Apple
```
Testing Instructions:
- To test in-app purchase, use StoreKit testing
- The app allows testing mode with FREE coins if IAP unavailable
- Snooze costs 2,000 coins, purchase gives 10,000 coins
- Alarm sound requires alarm_sound.mp3 file in bundle
```

## App Description Template

```
ALARM LOUDER - Wake Up or Pay Up! ⏰💰

Tired of hitting snooze 10 times? Alarm Louder uses a unique coin-based system that makes snoozing COST YOU MONEY.

🔊 EXTRA LOUD ALARMS
Maximum volume alarms with continuous vibration designed specifically for heavy sleepers.

💰 COIN-BASED SNOOZE SYSTEM
• Each snooze costs 2,000 coins
• Buy 10,000 coins for $1 (5 snoozes)
• Run out of coins? You MUST wake up!
• Creates real financial incentive to get out of bed

⏰ POWERFUL FEATURES
• Multiple alarms with custom times and labels
• Repeat options for specific days
• Customizable snooze duration (1-30 minutes)
• Persistent notifications - alarms work even when app is closed
• Beautiful, modern interface

💪 PERFECT FOR
• Heavy sleepers who hit snooze repeatedly
• People who need extra motivation to wake up
• Anyone struggling with alarm discipline

The psychology is simple: making snooze cost money makes you think twice before hitting that button. It's the accountability you need to finally wake up on time!

Download now and start waking up on your first alarm. Your wallet (and morning routine) will thank you.
```

## Privacy Policy Template

```
Privacy Policy for Alarm Louder

Last updated: [Date]

We respect your privacy. This app:
- Does NOT collect personal information
- Does NOT share data with third parties
- Stores alarm data locally on your device only
- Processes in-app purchases through Apple (subject to Apple's privacy policy)

Data Stored Locally:
- Alarm times and settings
- Coin balance
- User preferences

In-App Purchases:
- Processed by Apple Inc.
- Subject to Apple's Privacy Policy
- We do not receive or store payment information

Contact: [Your Email]
```

## Common Issues & Solutions

### Issue: "Missing Compliance"
Solution: Answer export compliance questions (app doesn't use encryption beyond standard iOS)

### Issue: "Invalid Binary - Missing Info.plist"
Solution: Ensure Info.plist has all required keys

### Issue: "In-App Purchase Not Found"
Solution:
1. Ensure Product ID matches exactly in both App Store Connect and CoinManager.swift
2. Wait 24 hours after creating IAP in App Store Connect
3. Sign agreement in App Store Connect → Agreements

### Issue: "App Rejected - Guideline 2.1"
Solution: Ensure alarm_sound.mp3 is included and app doesn't crash

## Post-Submission

- Review typically takes 1-3 days
- Monitor App Store Connect for status updates
- Respond promptly to any reviewer questions
- Once approved, app goes live automatically (or on date you specify)

## Pricing Strategy

Recommended: Free app with IAP
- Gives users chance to try the app
- Coin system provides recurring revenue
- Consider offering "coin packages" in future updates:
  - 10,000 coins: $0.99
  - 50,000 coins: $3.99 (20% discount)
  - 150,000 coins: $9.99 (33% discount)
