# Platform Testing Guide

## 🚀 Quick Start

### Android & iOS Testing

#### List Available Devices
```bash
flutter devices
```

#### Run on Specific Device
```bash
# List devices
flutter devices

# Run on device
flutter run -d <device_id>
```

---

## 🤖 Android

### Requirements
- Android SDK 21+
- Emulator running or device connected

### Run
```bash
# Run on Android
flutter run -d emulator-5554

# Build APK
flutter build apk --debug
flutter build apk --release

# Install APK on device
adb install build/app/outputs/apk/release/app-release.apk
```

### Emulator
```bash
# List emulators
flutter emulators

# Launch emulator
flutter emulators --launch <emulator_id>

# Or open Android Studio > Device Manager
```

---

## 🍎 iOS

### Requirements
- macOS 11+
- Xcode 13+
- iOS 13.0+

### Run
```bash
# Run on iOS simulator
flutter run -d <simulator_id>

# Run on physical device
flutter run -d <device_uuid>

# Build IPA
flutter build ios --release
```

### Simulator
```bash
# List available simulators
xcrun simctl list devices available

# Launch simulator
open -a Simulator

# Or from Xcode: Window > Devices and Simulators
```

### Physical Device
1. Connect via USB cable
2. Trust certificate: Settings > General > VPN & Device Management
3. Enable Developer Mode (if iOS 16+)
4. Run: `flutter run`

### Xcode
```bash
# Open Xcode workspace
open ios/Runner.xcworkspace

# Build from Xcode
# Select Runner scheme
# Select device/simulator
# Press Play
```

---

## 🔍 Debugging

### View Logs
```bash
flutter logs -d <device_id>
```

### Hot Reload
- Press `r` in terminal during flutter run
- Or use VS Code: Debug > Hot Reload

### Hot Restart
- Press `R` in terminal during flutter run

### Rebuild from Scratch
```bash
flutter clean
flutter pub get
flutter run
```

---

## 📱 Multi-Platform Development

### Run on Multiple Devices
```bash
# Terminal 1
flutter run -d emulator-5554

# Terminal 2 (new terminal)
flutter run -d <ios_device_id>
```

### Device Selector in VS Code
```json
// .vscode/launch.json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Flutter Android",
      "request": "launch",
      "type": "dart",
      "deviceId": "emulator-5554"
    },
    {
      "name": "Flutter iOS",
      "request": "launch",
      "type": "dart",
      "deviceId": "<ios_device_id>"
    }
  ]
}
```

---

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Widget Tests
```bash
flutter test test/widget_test.dart
```

### Integration Tests
```bash
flutter test integration_test/
```

---

## 📦 Build & Deploy

### Android
```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# App Bundle (for Play Store)
flutter build appbundle --release
```

### iOS
```bash
# Debug build
flutter build ios --debug

# Release build
flutter build ios --release

# IPA (for distribution)
flutter build ipa --release
```

---

## 🔧 Troubleshooting

### Android Issues
```bash
# Clean build
flutter clean
rm -rf build/ android/.gradle/

# Rebuild
flutter pub get
flutter run
```

### iOS Issues
```bash
# Clean build
flutter clean
cd ios && rm -rf Pods Podfile.lock && pod install && cd ..
flutter pub get
flutter run
```

### Device Not Detected
```bash
# Check devices
flutter devices

# Troubleshoot
flutter doctor
flutter doctor -v
```

### Connection Issues
```bash
# Reconnect device
adb kill-server (Android)
adb devices

# Reset Dart VM
flutter run --verbose
```

---

## 📚 Documentation
- [Flutter Docs](https://flutter.dev/docs)
- [Android Setup](https://flutter.dev/docs/get-started/install)
- [iOS Setup](iOS_SETUP_GUIDE.md)

Happy testing! 🎉
