# 🚀 Gaspi Mobile App - Android Setup

## ✅ Status Aplikasi

### Yang Sudah Selesai:
1. ✅ **Code Generation** - Semua file `.g.dart` sudah di-generate
2. ✅ **Mock Data Providers** - Tidak perlu API backend untuk development
3. ✅ **Clean Architecture** - Struktur folder dan file lengkap
4. ✅ **Android Only** - Fokus platform Android (iOS, web, dll sudah dihapus)
5. ✅ **UI Slicing Ready** - UI bisa langsung dilihat tanpa perlu API
6. ✅ **No Compilation Errors** - Aplikasi siap dijalankan

### Fitur yang Tersedia untuk UI Slicing:
- 🔐 **Login Page** - Form login dengan validasi
- 📦 **Delivery Order List** - Tampilan daftar DO dengan filter dan search
- 🔧 **Maintenance** - Mock data maintenance (struktur siap)

---

## 📱 Cara Menjalankan di Android

### Opsi 1: Android Emulator (Recommended)
```bash
# 1. Lihat emulator yang tersedia
flutter emulators

# 2. Launch emulator (ganti dengan nama emulator Anda)
flutter emulators --launch <emulator_id>

# 3. Jalankan aplikasi
flutter run
```

### Opsi 2: Real Device Android
```bash
# 1. Aktifkan USB Debugging di HP Android:
#    - Buka Settings > About Phone
#    - Tap "Build Number" 7x untuk aktifkan Developer Mode
#    - Kembali ke Settings > Developer Options
#    - Aktifkan "USB Debugging"

# 2. Hubungkan HP ke Mac dengan kabel USB

# 3. Cek device terdeteksi
flutter devices

# 4. Jalankan aplikasi
flutter run
```

### Opsi 3: Chrome (Web) - Untuk Quick Preview
```bash
# Jalankan di browser Chrome
flutter run -d chrome
```

---

## 🎯 Struktur Mock Data

### Delivery Order Mock Provider
**File:** `lib/features/delivery_order/presentation/providers/do_mock_provider.dart`

**Data yang tersedia:**
- 5 Delivery Order dengan berbagai status (pending, on_delivery, completed)
- Filter by status
- Search by DO number, customer name
- Pull-to-refresh
- Detail items per DO

**Contoh penggunaan:**
```dart
// Di dalam widget
final deliveryOrders = ref.watch(deliveryOrderListProvider);

// Filter by status
final pendingOrders = ref.watch(filteredDeliveryOrderProvider('pending'));

// Search
final searchResults = ref.watch(searchedDeliveryOrderProvider('DO-2024'));
```

### Maintenance Mock Provider
**File:** `lib/features/maintenance/presentation/providers/maintenance_mock_provider.dart`

**Data yang tersedia:**
- 5 Maintenance records dengan berbagai status
- Filter by status dan type
- Detail maintenance tasks
- Progress tracking

---

## 🔧 Development Commands

### Build & Run
```bash
# Run in debug mode
flutter run

# Run in profile mode (better performance)
flutter run --profile

# Run in release mode
flutter run --release

# Build APK
flutter build apk --release

# Build App Bundle (for Play Store)
flutter build appbundle --release
```

### Code Generation (jika ada perubahan model/provider)
```bash
# Generate sekali
dart run build_runner build --delete-conflicting-outputs

# Watch mode (auto generate on save)
dart run build_runner watch --delete-conflicting-outputs
```

### Clean & Reset
```bash
# Clean build cache
flutter clean

# Get dependencies
flutter pub get

# Rebuild everything
flutter clean && flutter pub get && dart run build_runner build --delete-conflicting-outputs
```

---

## 📂 Struktur Project (Android Focus)

```
gaspi_app/
├── android/                    # Platform Android
│   ├── app/
│   │   ├── src/main/
│   │   │   ├── AndroidManifest.xml
│   │   │   └── kotlin/
│   │   └── build.gradle.kts
│   └── build.gradle.kts
│
├── lib/
│   ├── core/                   # Core utilities
│   │   ├── constants/
│   │   ├── network/
│   │   ├── errors/
│   │   ├── theme/
│   │   ├── utils/
│   │   └── router/
│   │
│   ├── features/
│   │   ├── auth/
│   │   │   ├── domain/
│   │   │   ├── data/
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   └── login_page.dart    ✅ Ready
│   │   │       └── providers/
│   │   │           └── auth_provider.dart  ✅ Ready
│   │   │
│   │   ├── delivery_order/
│   │   │   ├── domain/
│   │   │   ├── data/
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   └── delivery_order_page.dart  ✅ Ready (Mock)
│   │   │       └── providers/
│   │   │           └── do_mock_provider.dart     ✅ Mock Data
│   │   │
│   │   └── maintenance/
│   │       ├── domain/
│   │       ├── data/
│   │       └── presentation/
│   │           └── providers/
│   │               └── maintenance_mock_provider.dart  ✅ Mock Data
│   │
│   └── main.dart               ✅ Entry point
│
├── test/
├── pubspec.yaml                ✅ Dependencies configured
└── analysis_options.yaml       ✅ Lint rules
```

---

## 🎨 Cara Kerja Mock Data

Aplikasi saat ini menggunakan **Mock Data** untuk development UI/UX tanpa perlu backend API:

### 1. **No API Required**
- Semua data hardcoded di provider
- Langsung return data tanpa HTTP request
- Sangat cepat untuk development

### 2. **Ganti ke Real API Nanti**
Ketika backend sudah ready, tinggal:

**Step 1:** Update API base URL di `lib/core/constants/app_constants.dart`:
```dart
static const String baseUrl = 'https://your-api.com/v1';
```

**Step 2:** Ganti import di page dari mock ke real provider:
```dart
// SEBELUM (Mock)
import '../providers/do_mock_provider.dart';

// SESUDAH (Real API)
import '../providers/do_provider.dart';
```

**Step 3:** Provider akan otomatis hit API dan fetch real data!

---

## 🐛 Troubleshooting

### Error: "No connected devices"
```bash
# Check device connection
adb devices

# Restart adb
adb kill-server
adb start-server
```

### Error: "Gradle build failed"
```bash
# Clean Android build
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

### Error: Build version issues
Pastikan di `android/app/build.gradle.kts`:
```kotlin
android {
    compileSdk = 34
    defaultConfig {
        minSdk = 21
        targetSdk = 34
    }
}
```

### Error: "Target of URI hasn't been generated"
```bash
# Generate ulang
dart run build_runner build --delete-conflicting-outputs
```

---

## 🚀 Next Steps - Development

### 1. **Slicing UI Halaman Lain**
- ECR (Empty Cylinder Return)
- Inventory Management
- Asset Tracking
- Dashboard
- User Management
- Reports

### 2. **Buat Mock Data untuk Setiap Feature**
Pattern yang sama seperti `do_mock_provider.dart`:
```dart
final yourFeatureListProvider = Provider<List<YourEntity>>((ref) {
  return _mockDataList;
});
```

### 3. **Test UI di Real Device**
- Install APK di HP untuk test real performance
- Test different screen sizes
- Test offline capability

### 4. **Integrasi API (Nanti)**
- Ganti mock provider dengan real provider
- Update API endpoints
- Test dengan backend

---

## 📝 Login Credentials (Mock)

Untuk testing login page, Anda bisa pakai data apapun karena masih mock:

```
Email: admin@gaspi.com
Password: password123

Email: supervisor@gaspi.com
Password: password123

Atau email/password apapun (akan berhasil login)
```

---

## 📞 Contact

Jika ada pertanyaan atau issue, silakan hubungi tim development.

**Happy Coding! 🎉**
