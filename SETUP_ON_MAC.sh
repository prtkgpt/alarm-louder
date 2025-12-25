#!/bin/bash

# Alarm Louder - Project Setup Script for MacBook
# Run this script to set up the project structure

echo "🚀 Setting up Alarm Louder project..."

# Get current directory
PROJECT_DIR=$(pwd)
echo "📁 Project will be created in: $PROJECT_DIR"

# Create directory structure
echo "📂 Creating directory structure..."
mkdir -p AlarmLouder/AlarmLouder.xcodeproj
mkdir -p AlarmLouder/AlarmLouder/Assets.xcassets/AppIcon.appiconset
mkdir -p AlarmLouder/AlarmLouder/Assets.xcassets/AccentColor.colorset

echo "✅ Directory structure created!"
echo ""
echo "⚠️  NEXT STEPS:"
echo "1. Copy all Swift files to AlarmLouder/AlarmLouder/"
echo "2. Copy project.pbxproj to AlarmLouder/AlarmLouder.xcodeproj/"
echo "3. Copy Info.plist to AlarmLouder/AlarmLouder/"
echo "4. Copy Products.storekit to AlarmLouder/AlarmLouder/"
echo "5. Add alarm_sound.mp3 to AlarmLouder/AlarmLouder/"
echo "6. Add app icons to Assets.xcassets/AppIcon.appiconset/"
echo ""
echo "📝 Documentation files to copy to project root:"
echo "   - README.md"
echo "   - APP_STORE_SUBMISSION.md"
echo "   - CHECKLIST.md"
echo "   - PRIVACY_POLICY.md"
echo "   - .gitignore"
echo ""
echo "Then open: AlarmLouder/AlarmLouder.xcodeproj"
