# 🚀 Gaspi Mobile App

**Gas LPG Management System** - Mobile Application for Android

## ✅ Status Project

- ✅ Clean Architecture Implementation
- ✅ Mock Data Ready (No API needed for development)
- ✅ Android Platform Only
- ✅ UI/UX Slicing Ready
- ✅ No Compilation Errors

## 🎯 Quick Start

### 1️⃣ Install Dependencies
```bash
flutter pub get
```

### 2️⃣ Run Aplikasi

**Option A: Android Emulator**
```bash
flutter emulators --launch <emulator_id>
flutter run
```

**Option B: Real Android Device**
```bash
# Enable USB Debugging di HP Android
# Connect ke Mac dengan kabel USB
flutter run
```

**Option C: Chrome (Preview Only)**
```bash
flutter run -d chrome
```

## 📱 Features

### ✅ Implemented (Mock Data)
- 🔐 **Login** - Authentication page
- 📦 **Delivery Order** - List, filter, search DO
- 🔧 **Maintenance** - Mock data structure ready

### 🚧 Coming Soon
- 📦 ECR (Empty Cylinder Return)
- 📊 Inventory Management
- 🏷️ Asset Tracking
- 📈 Dashboard
- 👥 User Management
- 📊 Reports

## 🏗️ Architecture

```
Clean Architecture + Riverpod
├── Domain Layer (Entities, Repository Interfaces)
├── Data Layer (Models, DataSources, Repository Impl)
└── Presentation Layer (UI, Providers)
```

## 🛠️ Tech Stack

- **Flutter** 3.9.0
- **Riverpod** - State Management
- **Go Router** - Navigation
- **Dio** - HTTP Client
- **Clean Architecture** - Project Structure

## 📚 Documentation

- 📖 [Android Setup Guide](ANDROID_SETUP.md) - Lengkap!
- 📖 [Architecture Guide](ARCHITECTURE.md)
- 📖 [Implementation Summary](IMPLEMENTATION_SUMMARY.md)
- 📖 [Cheat Sheet](CHEAT_SHEET.md)
- 📖 [File Structure](FILE_STRUCTURE.md)

## 🔧 Development Commands

```bash
# Run app
flutter run

# Build APK
flutter build apk --release

# Code generation (if needed)
dart run build_runner build --delete-conflicting-outputs

# Clean
flutter clean && flutter pub get
```

## 👥 User Roles (RBAC)

1. **Superadmin** - Full access
2. **Admin** - Management access
3. **Supervisor** - Monitoring access
4. **Coordinator** - Coordination access
5. **Production** - Production access
6. **Maintenance** - Maintenance access

## 🎨 Mock Data

Aplikasi menggunakan **Mock Data** untuk development UI tanpa perlu backend:

- ✅ 5 Delivery Orders dengan berbagai status
- ✅ 5 Maintenance records
- ✅ Filter, search, pull-to-refresh works
- ✅ Ready untuk ganti ke Real API nanti

**Lihat:** `lib/features/*/presentation/providers/*_mock_provider.dart`

## 📝 Login Testing

Mock login - bisa pakai email/password apapun:
```
Email: admin@gaspi.com
Password: password123
```

## 🚀 Deploy

### Build APK
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### Build App Bundle (Play Store)
```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

## 📞 Support

Untuk pertanyaan atau issue, hubungi tim development.

---

**Made with ❤️ by Gaspi Team**
