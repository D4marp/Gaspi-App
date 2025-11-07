# iOS Setup Guide - Gaspi Mobile App

## ✅ iOS Platform Restored!

### Setup Selesai
- ✅ iOS folder structure
- ✅ CocoaPods setup
- ✅ Bundle identifier configured
- ✅ App display name: "Gaspi Mobile App"
- ✅ Assets dan launcher screen configured

### Persyaratan Sistem
- macOS 11 atau lebih baru
- Xcode 13 atau lebih baru (di-install dari App Store)
- Cocoapods: `sudo gem install cocoapods`
- Apple Developer Account (untuk testing di device)

### Cara Build & Run

#### 1. Emulator iOS
```bash
# Open iOS simulator
open -a Simulator

# Run app
flutter run -d <device_id>

# List available devices
flutter devices
```

#### 2. Physical Device
```bash
# Connect via USB
# Ensure device is trusted
flutter run -d <device_uuid>
```

#### 3. Direct Xcode
```bash
# Open Xcode workspace
open ios/Runner.xcworkspace

# Build and run dari Xcode
# Select Runner scheme dan device
# Press Play button
```

### Folder Structure
```
ios/
├── Runner.xcworkspace/          # Xcode workspace
├── Runner.xcodeproj/            # Xcode project
├── Flutter/                     # Flutter framework configuration
│   ├── Debug.xcconfig
│   ├── Release.xcconfig
│   └── AppFrameworkInfo.plist
├── Runner/                      # App files
│   ├── AppDelegate.swift        # App entry point
│   ├── Info.plist              # App configuration
│   ├── Assets.xcassets/        # Icons & launch images
│   └── Base.lproj/             # Storyboards
├── RunnerTests/                 # Unit tests
└── .gitignore
```

### Konfigurasi Penting

#### Bundle Identifier
File: `ios/Runner.xcodeproj/project.pbxproj`
Default: `com.example.gaspiApp`
Ubah sesuai kebutuhan untuk App Store

#### App Icon
Update di: `ios/Runner/Assets.xcassets/AppIcon.appiconset/`
- Ukuran: 1024x1024px untuk universal
- Format: PNG dengan transparency

#### Launch Screen
Update di: `ios/Runner/Base.lproj/LaunchScreen.storyboard`
atau `ios/Runner/Assets.xcassets/LaunchImage.imageset/`

### Common Issues

#### Pod Error: "CDN: trunk Repo update failed"
```bash
cd ios
pod repo update
cd ..
flutter clean
flutter pub get
```

#### Xcode Building Error
```bash
cd ios
rm -rf Pods
rm Podfile.lock
pod install
cd ..
flutter clean
flutter pub get
```

#### Device Locked/Untrusted
1. Unlock device
2. Trust certificate: Settings > General > Device Management
3. Try again: `flutter run`

#### Signing Issues
```bash
# Clear signing settings
flutter config --clear-ios-signing-settings

# Re-configure
flutter run
```

### Supported iOS Version
- Target: iOS 12.0 atau lebih baru
- Set di: `ios/Podfile`

### Useful Commands
```bash
# Clean build
flutter clean

# Get dependencies
flutter pub get

# Analyze
flutter analyze

# Build release version
flutter build ios --release

# Build without code signing (for testing)
flutter build ios --no-codesign

# View logs
flutter logs

# Run with verbose output
flutter run -v
```

### Testing
```bash
# Run unit tests
flutter test

# Run widget tests
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

### Deployment

#### Ad Hoc Build
```bash
flutter build ios --release
# Then use Xcode to generate Ad Hoc build
```

#### App Store
1. Update version di `pubspec.yaml`
2. Update bundle version di `ios/Runner.xcodeproj/project.pbxproj`
3. Build: `flutter build ipa`
4. Upload ke App Store Connect

#### TestFlight
```bash
flutter build ipa
# Upload dari App Store Connect
```

### Resources
- [Flutter iOS Docs](https://flutter.dev/docs/get-started/install/macos#ios-setup)
- [Xcode Documentation](https://developer.apple.com/xcode/)
- [Swift Documentation](https://docs.swift.org/)

### Next Steps
1. Update Bundle Identifier
2. Set correct development team
3. Configure push notifications (jika diperlukan)
4. Add capabilities (camera, location, etc.) di Xcode

Siap testing di iOS! 🍎
