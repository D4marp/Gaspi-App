# Gaspi Mobile App

Aplikasi manajemen Gas LPG berbasis Flutter dengan Clean Architecture dan Riverpod.

## 🚀 Quick Start

### Prerequisites
- Flutter SDK ≥ 3.9.0
- Dart SDK ≥ 3.9.0

### Installation

1. Clone repository
```bash
git clone <repository-url>
cd gaspi_app
```

2. Install dependencies
```bash
flutter pub get
```

3. Generate code
```bash
dart run build_runner build --delete-conflicting-outputs
```

4. Run app
```bash
flutter run
```

## 📋 Features

✅ Role-Based Access Control (6 roles)  
✅ Delivery Order Management  
✅ Empty Cylinder Return  
✅ Inventory Management  
✅ Asset Tracking  
✅ Maintenance (RBA)  

## 🏗️ Architecture

Clean Architecture dengan 3 layers:
- **Presentation** - UI, Pages, Providers (Riverpod)
- **Domain** - Entities, UseCases, Repository interfaces
- **Data** - Models, DataSources, Repository implementations

Baca dokumentasi lengkap di [ARCHITECTURE.md](ARCHITECTURE.md)

## 🔧 Tech Stack

- **Flutter** - UI Framework
- **Riverpod** - State Management
- **GoRouter** - Routing with RBAC
- **Dio** - HTTP Client
- **json_serializable** - JSON parsing
- **flutter_secure_storage** - Secure token storage

## 📱 Roles

1. **Superadmin** - Full access
2. **Admin** - High-level access
3. **Supervisor** - View & approve
4. **Coordinator** - CRUD operations
5. **Production** - DO & Inventory focus
6. **Maintenance** - Asset & RBA focus

## 🛠️ Development

### Code Generation
```bash
# Watch mode (auto-generate)
dart run build_runner watch --delete-conflicting-outputs

# One-time build
dart run build_runner build --delete-conflicting-outputs
```

### Folder Structure
```
lib/
├── core/           # Shared utilities
├── features/       # Feature modules
│   ├── auth/
│   ├── delivery_order/
│   ├── maintenance/
│   └── ...
└── main.dart
```

### Adding New Feature

1. Create folder structure in `lib/features/new_feature/`
2. Implement domain entities & repositories
3. Create data models & datasources
4. Build presentation layer (pages, widgets, providers)
5. Add routes in `app_router.dart`
6. Implement RBAC permissions

## 🔒 API Configuration

Edit `lib/core/constants/app_constants.dart`:
```dart
static const String baseUrl = 'https://your-api.com/v1';
```

## 📖 Documentation

Lihat [ARCHITECTURE.md](ARCHITECTURE.md) untuk:
- Detailed architecture explanation
- Data flow diagrams
- RBAC implementation guide
- Development best practices
- Code examples

## 🧪 Testing

```bash
# Unit tests
flutter test

# Widget tests
flutter test test/widget_test.dart
```

## 📦 Build

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## 📝 License

Proprietary - All rights reserved

## 👥 Team

Developed by [Your Team Name]

---

For detailed documentation, see [ARCHITECTURE.md](ARCHITECTURE.md)
