# 🚀 Gaspi Mobile App - Complete Architecture Guide

## 📋 Table of Contents
- [Overview](#overview)
- [Architecture](#architecture)
- [Folder Structure](#folder-structure)
- [Data Flow](#data-flow)
- [Role-Based Access Control](#role-based-access-control)
- [Setup & Installation](#setup--installation)
- [Code Generation](#code-generation)
- [Development Guide](#development-guide)

---

## 🎯 Overview

**Gaspi Mobile App** adalah aplikasi manajemen Gas LPG yang dibangun dengan:
- **Flutter** - Framework UI
- **Clean Architecture** - Arsitektur aplikasi
- **Riverpod** - State management
- **GoRouter** - Routing dengan RBAC
- **Dio** - HTTP client untuk API integration

### Fitur Utama
✅ **Role-Based Access Control (RBAC)** - 6 peran pengguna  
✅ **Delivery Order Management** - DO tracking & confirmation  
✅ **Empty Cylinder Return (ECR)** - Return tracking  
✅ **Inventory Management** - Stock & movement  
✅ **Asset Tracking** - Asset monitoring  
✅ **Maintenance (RBA)** - Preventive & corrective maintenance  

---

## 🏗️ Architecture

Aplikasi ini menggunakan **Clean Architecture** dengan 3 layer utama:

```
┌─────────────────────────────────────────┐
│         PRESENTATION LAYER              │
│  (UI, Pages, Widgets, Providers)        │
│         ↓ uses ↓                        │
├─────────────────────────────────────────┤
│           DOMAIN LAYER                   │
│  (Entities, UseCases, Repositories)     │
│         ↑ implements ↑                  │
├─────────────────────────────────────────┤
│            DATA LAYER                    │
│  (Models, DataSources, Repository Impl) │
└─────────────────────────────────────────┘
```

### Prinsip Clean Architecture:
1. **Domain Layer** tidak bergantung pada layer lain
2. **Data Layer** mengimplementasikan interface dari Domain
3. **Presentation Layer** hanya bergantung pada Domain
4. **Dependency Rule**: Dependencies hanya ke arah dalam (inward)

---

## 📁 Folder Structure

```
lib/
├── core/                          # Shared/core utilities
│   ├── constants/
│   │   ├── app_constants.dart    # Config & constants
│   │   ├── api_endpoints.dart    # API endpoints
│   │   └── user_role.dart        # Role enum & permissions
│   ├── network/
│   │   ├── dio_client.dart       # Dio setup & interceptors
│   │   └── api_service.dart      # Base API service
│   ├── errors/
│   │   └── app_exception.dart    # Custom exceptions
│   ├── theme/
│   │   └── app_theme.dart        # App theme & colors
│   ├── utils/
│   │   ├── date_formatter.dart   # Date utilities
│   │   ├── currency_formatter.dart
│   │   └── dialog_helper.dart    # Dialogs & snackbars
│   └── router/
│       └── app_router.dart       # GoRouter with RBAC
│
├── features/                      # Feature modules
│   ├── auth/                     # Authentication feature
│   │   ├── data/
│   │   │   ├── models/          # UserModel, AuthResponseModel
│   │   │   ├── datasources/     # Remote & Local datasources
│   │   │   └── repositories/    # Repository implementation
│   │   ├── domain/
│   │   │   ├── entities/        # User entity
│   │   │   ├── repositories/    # Repository interface
│   │   │   └── usecases/        # Login, Logout usecases
│   │   └── presentation/
│   │       ├── pages/           # LoginPage
│   │       ├── widgets/         # Reusable widgets
│   │       └── providers/       # auth_provider.dart (Riverpod)
│   │
│   ├── delivery_order/           # Delivery Order feature
│   │   ├── data/
│   │   │   ├── models/
│   │   │   ├── datasources/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── pages/           # DeliveryOrderPage
│   │       ├── widgets/
│   │       └── providers/       # do_provider.dart
│   │
│   ├── maintenance/              # Maintenance feature
│   │   └── [same structure]
│   │
│   └── [other features...]       # ECR, Inventory, Asset, etc.
│
└── main.dart                     # App entry point
```

---

## 🔄 Data Flow

### Alur Data: API → Provider → UI

```
┌──────────────┐
│   UI/Page    │ ← Watch provider state
└──────┬───────┘
       │ Call method
┌──────▼────────┐
│   Provider    │ ← State management (Riverpod)
│ (AsyncNotifier)│
└──────┬────────┘
       │ Call usecase
┌──────▼────────┐
│   UseCase     │ ← Business logic
└──────┬────────┘
       │ Call repository
┌──────▼────────┐
│  Repository   │ ← Interface (domain)
│ Implementation│
└──────┬────────┘
       │ Call datasource
┌──────▼────────┐
│  DataSource   │ ← API calls (Dio)
│   (Remote)    │
└──────┬────────┘
       │ HTTP Request
┌──────▼────────┐
│   API Server  │
└───────────────┘
```

### Contoh Praktis: Login Flow

1. **User tap tombol Login** di `LoginPage`
2. **UI calls** `ref.read(authProvider.notifier).login(email, password)`
3. **AuthProvider** memanggil `LoginUseCase`
4. **LoginUseCase** memanggil `AuthRepository.login()`
5. **AuthRepositoryImpl** memanggil `AuthRemoteDataSource.login()`
6. **DataSource** melakukan HTTP POST ke API
7. **Response** dikembalikan ke DataSource → Repository → UseCase → Provider
8. **Provider updates state** menjadi `AsyncValue.data(authState)`
9. **UI rebuilds** karena watching provider
10. **Navigate** ke HomePage jika sukses

---

## 🔐 Role-Based Access Control (RBAC)

### 6 Role dalam Sistem

| Role | Akses | Deskripsi |
|------|-------|-----------|
| **Superadmin** | Full Access | Akses penuh ke semua fitur |
| **Admin** | High Access | Akses ke semua kecuali system config |
| **Supervisor** | View & Approve | View, approve, export |
| **Coordinator** | CRUD | View, create, update |
| **Production** | DO & Inventory | Fokus pada delivery & stock |
| **Maintenance** | Asset & RBA | Fokus pada asset & maintenance |

### Implementasi RBAC

#### 1. Define Permissions di `user_role.dart`
```dart
enum UserRole {
  superadmin, admin, supervisor, coordinator, production, maintenance;
  
  bool hasPermission(String module, String action) {
    // Logic untuk check permission
  }
}
```

#### 2. Route Protection di `app_router.dart`
```dart
redirect: (context, state) {
  if (location.startsWith('/maintenance')) {
    if (!currentUser.role.hasPermission('maintenance', 'view')) {
      return '/unauthorized';
    }
  }
}
```

#### 3. UI Conditional Rendering
```dart
if (user?.role.hasPermission('delivery_order', 'view') ?? false)
  _MenuCard(
    title: 'Delivery Order',
    onTap: () => context.push('/delivery-orders'),
  ),
```

---

## ⚙️ Setup & Installation

### 1. Install Dependencies
```bash
flutter pub get
```

### 2. Generate Code (json_serializable, riverpod_generator)
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3. Update API Base URL
Edit `lib/core/constants/app_constants.dart`:
```dart
static const String baseUrl = 'https://your-api.com/v1';
```

### 4. Run Application
```bash
flutter run
```

---

## 🔨 Code Generation

File yang memerlukan code generation:
- `*.g.dart` untuk json_serializable
- `*.g.dart` untuk riverpod_generator

### Watch Mode (Auto-generate saat ada perubahan)
```bash
dart run build_runner watch --delete-conflicting-outputs
```

### One-time Build
```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## 💻 Development Guide

### Menambahkan Feature Baru

**Langkah-langkah:**

#### 1. Buat Struktur Folder
```
lib/features/new_feature/
├── data/
│   ├── models/
│   ├── datasources/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── pages/
    ├── widgets/
    └── providers/
```

#### 2. Define Entity (Domain Layer)
```dart
// lib/features/new_feature/domain/entities/item.dart
class Item extends Equatable {
  final String id;
  final String name;
  
  const Item({required this.id, required this.name});
  
  @override
  List<Object> get props => [id, name];
}
```

#### 3. Create Model (Data Layer)
```dart
// lib/features/new_feature/data/models/item_model.dart
@JsonSerializable()
class ItemModel {
  final String id;
  final String name;
  
  ItemModel({required this.id, required this.name});
  
  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);
  
  Item toEntity() => Item(id: id, name: name);
}
```

#### 4. Create Repository Interface (Domain)
```dart
// lib/features/new_feature/domain/repositories/item_repository.dart
abstract class ItemRepository {
  Future<List<Item>> getItems();
  Future<Item> getItemById(String id);
}
```

#### 5. Implement Repository (Data Layer)
```dart
// lib/features/new_feature/data/repositories/item_repository_impl.dart
class ItemRepositoryImpl implements ItemRepository {
  final ItemRemoteDataSource dataSource;
  
  @override
  Future<List<Item>> getItems() async {
    final models = await dataSource.getItems();
    return models.map((m) => m.toEntity()).toList();
  }
}
```

#### 6. Create Provider (Presentation)
```dart
// lib/features/new_feature/presentation/providers/item_provider.dart
@riverpod
class ItemList extends _$ItemList {
  @override
  Future<List<Item>> build() async {
    final repository = ref.read(itemRepositoryProvider);
    return await repository.getItems();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => /* fetch data */);
  }
}
```

#### 7. Create UI Page
```dart
// lib/features/new_feature/presentation/pages/item_page.dart
class ItemPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(itemListProvider);
    
    return itemsAsync.when(
      data: (items) => ListView.builder(...),
      loading: () => CircularProgressIndicator(),
      error: (e, st) => Text('Error: $e'),
    );
  }
}
```

---

## 🎨 Tips untuk Scalability

### 1. Gunakan Feature-First Structure
Setiap feature dalam folder terpisah, mudah di-maintain

### 2. Pisahkan Business Logic dari UI
Semua logic ada di Provider/UseCase, bukan di Widget

### 3. Reusable Widgets
Buat widgets kecil yang reusable:
```dart
// lib/core/widgets/
├── custom_button.dart
├── loading_indicator.dart
└── empty_state.dart
```

### 4. Consistent Naming Convention
- **Files**: `snake_case.dart`
- **Classes**: `PascalCase`
- **Variables**: `camelCase`
- **Providers**: `nameProvider` (suffix Provider)

### 5. Error Handling Konsisten
Gunakan `AppException` hierarchy untuk semua error

### 6. Logging
Tambahkan logger untuk debugging:
```dart
final logger = Logger();
logger.d('Debug message');
logger.e('Error message', error, stackTrace);
```

---

## 🧪 Testing

### Unit Test (Domain & Data Layer)
```dart
test('should return list of items', () async {
  final items = await repository.getItems();
  expect(items, isA<List<Item>>());
});
```

### Widget Test (Presentation Layer)
```dart
testWidgets('should display items', (tester) async {
  await tester.pumpWidget(ProviderScope(child: ItemPage()));
  expect(find.byType(ListView), findsOneWidget);
});
```

---

## 📱 API Integration

### Format Response yang Diharapkan

```json
{
  "status": "success",
  "message": "Data retrieved successfully",
  "data": {
    "id": "123",
    "name": "Item Name"
  }
}
```

### Error Response
```json
{
  "status": "error",
  "message": "Error message",
  "errors": {
    "field": ["Validation error"]
  }
}
```

---

## 🔒 Security

1. **Token disimpan di Secure Storage** (flutter_secure_storage)
2. **Auto token refresh** via interceptor
3. **RBAC di route level** - Unauthorized access blocked
4. **Input validation** di semua form
5. **HTTPS only** untuk production

---

## 📊 State Management Pattern

### AsyncNotifier Pattern (Recommended)
```dart
@riverpod
class DataList extends _$DataList {
  @override
  Future<List<Data>> build() async {
    return _fetchData();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchData());
  }
}
```

### StateNotifier Pattern (Alternative)
```dart
class DataNotifier extends StateNotifier<AsyncValue<List<Data>>> {
  DataNotifier() : super(const AsyncValue.loading()) {
    _fetchData();
  }
  
  Future<void> _fetchData() async {
    state = await AsyncValue.guard(() async {
      // Fetch logic
    });
  }
}
```

---

## 🚀 Production Checklist

- [ ] Set `baseUrl` ke production API
- [ ] Remove `debugShowCheckedModeBanner`
- [ ] Configure app icons & splash screen
- [ ] Setup Firebase (if needed)
- [ ] Configure ProGuard (Android)
- [ ] Setup signing keys
- [ ] Test on real devices
- [ ] Performance optimization
- [ ] Security audit

---

## 📞 Support

Untuk pertanyaan atau issue, silakan hubungi tim development.

---

**Happy Coding! 🎉**
