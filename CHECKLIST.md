# App Store Submission Checklist

Use this checklist to ensure you've completed all steps before submitting to the App Store.

## ☐ Pre-Submission Setup

### Apple Developer Account
- [ ] Enrolled in Apple Developer Program ($99/year)
- [ ] Accepted all agreements in App Store Connect
- [ ] Accepted Paid Applications agreement (required for IAP)
- [ ] Set up banking/tax information (for IAP revenue)

### Xcode Project Configuration
- [ ] Selected development team in Signing & Capabilities
- [ ] Bundle ID configured: `com.alarmlouder.app` (or your unique ID)
- [ ] Version number set: `1.0`
- [ ] Build number set: `1`
- [ ] Deployment target: iOS 16.0 or higher
- [ ] In-App Purchase capability added
- [ ] Info.plist has notification permission description ✓

### Required Assets
- [ ] App Icon created (1024x1024 for App Store)
- [ ] App Icon added to all required sizes in Assets.xcassets
- [ ] alarm_sound.mp3 file added to project (CRITICAL - currently missing!)
- [ ] Sound file added to project target (check in Build Phases → Copy Resources)

## ☐ App Store Connect Setup

### Create App Record
- [ ] Created new app in App Store Connect
- [ ] Bundle ID matches Xcode project
- [ ] Primary language set (English)
- [ ] SKU assigned

### In-App Purchase Configuration
- [ ] Created consumable IAP: "10,000 Coins"
- [ ] Product ID: `com.alarmlouder.coins10000` (matches CoinManager.swift)
- [ ] Price set to $0.99 (Tier 1)
- [ ] Display name: "10,000 Coins"
- [ ] Description added
- [ ] Localization completed for primary language
- [ ] IAP marked as "Ready to Submit"
- [ ] **IMPORTANT**: Submit IAP with first app version

### App Metadata
- [ ] App name: "Alarm Louder"
- [ ] Subtitle: Created (max 30 characters)
- [ ] Description: Written (see APP_STORE_SUBMISSION.md)
- [ ] Keywords: Added (max 100 characters)
- [ ] Screenshots: Created and uploaded (all required sizes)
- [ ] Privacy Policy URL: Added (host PRIVACY_POLICY.md somewhere)
- [ ] Support URL: Added
- [ ] Marketing URL: Added (optional)

### App Information
- [ ] Category: Selected (Productivity or Lifestyle)
- [ ] Age rating: Completed questionnaire
- [ ] Copyright: Added
- [ ] Price: Set to Free
- [ ] Availability: Countries selected

## ☐ Testing

### StoreKit Testing
- [ ] Tested coin purchase with Products.storekit in Xcode
- [ ] Verified 10,000 coins are added after purchase
- [ ] Tested snooze deducting 2,000 coins
- [ ] Tested insufficient coins alert
- [ ] Verified coin balance persists after app restart

### Core Functionality
- [ ] Alarms trigger at correct time
- [ ] Alarm sound plays (CRITICAL - needs alarm_sound.mp3!)
- [ ] Notification appears when app is closed
- [ ] Vibration works
- [ ] Snooze creates new alarm at correct time
- [ ] Dismiss turns off alarm
- [ ] Multiple alarms work
- [ ] Repeat alarms work correctly
- [ ] Edit alarm updates correctly
- [ ] Delete alarm works

### UI Testing
- [ ] All screens display correctly on various iPhone sizes
- [ ] Coin balance displays correctly
- [ ] Purchase screen works
- [ ] No crashes or UI glitches
- [ ] Dark mode looks good (if applicable)
- [ ] VoiceOver accessibility works (optional but recommended)

## ☐ Build and Archive

### Archive Preparation
- [ ] Set scheme to Release configuration
- [ ] Selected "Any iOS Device" as destination
- [ ] Cleaned build folder (Product → Clean Build Folder)
- [ ] Product → Archive completed successfully
- [ ] No warnings in build log (fix if possible)

### Upload to App Store Connect
- [ ] Distribute App → App Store Connect
- [ ] Upload completed successfully
- [ ] Build processing completed in App Store Connect (10-60 minutes)
- [ ] Build appears in "Activity" tab
- [ ] Build has no validation issues

## ☐ Final Submission

### Review Information
- [ ] Added build to app version
- [ ] Screenshots uploaded for all required device sizes
- [ ] App description proofread (no typos!)
- [ ] Privacy Policy reviewed
- [ ] Age rating confirmed
- [ ] Export Compliance answered (select "No" if app doesn't use custom encryption)

### Submit for Review
- [ ] Reviewed all information one final time
- [ ] Clicked "Submit for Review"
- [ ] Answered any additional questions
- [ ] Received confirmation email from Apple

## ☐ Post-Submission

- [ ] Monitor App Store Connect for status updates
- [ ] Check email for any messages from Apple Review team
- [ ] Prepare to respond to reviewer questions within 24 hours
- [ ] Plan marketing/launch strategy for when approved

## 🚨 Common Rejection Reasons to Avoid

- [ ] Missing alarm_sound.mp3 file (app crashes)
- [ ] IAP not properly configured in App Store Connect
- [ ] Screenshots don't show actual app functionality
- [ ] Privacy Policy missing or inadequate
- [ ] App crashes on launch
- [ ] Export compliance not answered correctly
- [ ] Metadata contains prohibited content (no competitor mentions)
- [ ] Test account not provided (if app requires login - N/A for this app)

## 📝 Notes

**Estimated Timeline:**
- Build upload and processing: 10-60 minutes
- Review time: 1-3 days (typically)
- Total time to App Store: 2-4 days

**Critical Missing Item:**
⚠️ **ALARM_SOUND.MP3** - You MUST add this file before archiving! The app will crash without it.

**After Approval:**
- App goes live automatically (or on scheduled date)
- Monitor reviews and ratings
- Respond to user feedback
- Plan updates and new features

**Revenue:**
- IAP revenue paid monthly by Apple (minus 30% commission for first year, 15% after)
- Set up banking info in App Store Connect to receive payments
- Track sales in App Store Connect → Sales and Trends

---

Good luck with your submission! 🚀
