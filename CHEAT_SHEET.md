# 📝 Gaspi App - Developer Cheat Sheet

## 🚀 Quick Commands

### Setup & Installation
```bash
# First time setup
flutter pub get
dart run build_runner build --delete-conflicting-outputs

# Or use helper script
./dev.sh   # Select option 1
```

### Development
```bash
# Run app
flutter run

# Run with specific device
flutter run -d <device_id>

# Run in profile mode
flutter run --profile

# Run in release mode
flutter run --release
```

### Code Generation
```bash
# One-time generation
dart run build_runner build --delete-conflicting-outputs

# Watch mode (auto-generate)
dart run build_runner watch --delete-conflicting-outputs

# Clean and rebuild
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

### Testing
```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/features/auth/auth_test.dart

# Run with coverage
flutter test --coverage

# View coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Building
```bash
# Android APK (debug)
flutter build apk

# Android APK (release)
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS (release)
flutter build ios --release

# iOS (debug)
flutter build ios --debug
```

### Maintenance
```bash
# Clean project
flutter clean

# Get dependencies
flutter pub get

# Update dependencies
flutter pub upgrade

# Check outdated packages
flutter pub outdated

# Analyze code
flutter analyze

# Format code
dart format lib/
```

---

## 📂 Key File Locations

### Configuration
```
lib/core/constants/app_constants.dart     # API URL, keys, config
lib/core/constants/api_endpoints.dart     # All API endpoints
lib/core/constants/user_role.dart         # Roles & permissions
```

### Network
```
lib/core/network/dio_client.dart          # Dio setup & interceptors
lib/core/network/api_service.dart         # Base API service
```

### Router
```
lib/core/router/app_router.dart           # Routes with RBAC
```

### Theme & Utils
```
lib/core/theme/app_theme.dart             # App theme & colors
lib/core/utils/dialog_helper.dart         # Dialogs & snackbars
lib/core/utils/date_formatter.dart        # Date formatting
lib/core/utils/currency_formatter.dart    # Currency formatting
```

---

## 🎯 Common Code Patterns

### 1. Creating a New Feature

```dart
// 1. Create entity (domain/entities/)
class Item extends Equatable {
  final String id;
  final String name;
  
  const Item({required this.id, required this.name});
  
  @override
  List<Object> get props => [id, name];
}

// 2. Create repository interface (domain/repositories/)
abstract class ItemRepository {
  Future<List<Item>> getItems();
}

// 3. Create model (data/models/)
@JsonSerializable()
class ItemModel {
  final String id;
  final String name;
  
  ItemModel({required this.id, required this.name});
  
  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);
  
  Item toEntity() => Item(id: id, name: name);
}

// 4. Create datasource (data/datasources/)
class ItemRemoteDataSource {
  final ApiService _apiService;
  
  Future<List<ItemModel>> getItems() async {
    final response = await _apiService.get('/api/items');
    return (response.data['data'] as List)
        .map((json) => ItemModel.fromJson(json))
        .toList();
  }
}

// 5. Implement repository (data/repositories/)
class ItemRepositoryImpl implements ItemRepository {
  final ItemRemoteDataSource dataSource;
  
  @override
  Future<List<Item>> getItems() async {
    final models = await dataSource.getItems();
    return models.map((m) => m.toEntity()).toList();
  }
}

// 6. Create provider (presentation/providers/)
@riverpod
class ItemList extends _$ItemList {
  @override
  Future<List<Item>> build() async {
    final repository = ref.read(itemRepositoryProvider);
    return await repository.getItems();
  }
  
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(itemRepositoryProvider);
      return await repository.getItems();
    });
  }
}

// 7. Create page (presentation/pages/)
class ItemPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(itemListProvider);
    
    return Scaffold(
      appBar: AppBar(title: const Text('Items')),
      body: itemsAsync.when(
        data: (items) => ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(title: Text(items[index].name));
          },
        ),
        loading: () => const CircularProgressIndicator(),
        error: (e, st) => Text('Error: $e'),
      ),
    );
  }
}
```

### 2. API Call Pattern

```dart
// GET request
final response = await apiService.get('/api/items');

// POST request
final response = await apiService.post(
  '/api/items',
  data: {'name': 'New Item'},
);

// PUT request
final response = await apiService.put(
  '/api/items/123',
  data: {'name': 'Updated Item'},
);

// DELETE request
final response = await apiService.delete('/api/items/123');
```

### 3. Provider Patterns

```dart
// Simple provider
@riverpod
String userName(Ref ref) {
  return 'John Doe';
}

// Async provider
@riverpod
Future<User> currentUser(Ref ref) async {
  final repository = ref.read(userRepositoryProvider);
  return await repository.getCurrentUser();
}

// Notifier provider (with state)
@riverpod
class Counter extends _$Counter {
  @override
  int build() => 0;
  
  void increment() => state++;
  void decrement() => state--;
}

// AsyncNotifier provider
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

### 4. Navigation

```dart
// Navigate to route
context.push('/delivery-orders');

// Navigate and replace
context.go('/home');

// Navigate back
context.pop();

// Navigate with parameters
context.push('/delivery-orders/123');
```

### 5. Show Dialogs & Snackbars

```dart
// Success message
SnackBarHelper.showSuccess(context, 'Data berhasil disimpan');

// Error message
SnackBarHelper.showError(context, 'Terjadi kesalahan');

// Confirmation dialog
final confirmed = await DialogHelper.showConfirmation(
  context,
  title: 'Konfirmasi',
  message: 'Apakah anda yakin?',
);

// Loading dialog
DialogHelper.showLoading(context, message: 'Loading...');
// ... do work ...
DialogHelper.hideLoading(context);
```

### 6. Check User Role & Permission

```dart
// Get current user
final user = ref.watch(currentUserProvider);

// Check if authenticated
final isAuth = ref.watch(isAuthenticatedProvider);

// Check permission
if (user?.role.hasPermission('delivery_order', 'view') ?? false) {
  // Show feature
}

// Check if admin
if (user?.role.isAdmin ?? false) {
  // Show admin features
}
```

### 7. Error Handling

```dart
try {
  await repository.doSomething();
} on UnauthorizedException catch (e) {
  // Handle unauthorized
  context.go('/login');
} on NetworkException catch (e) {
  // Handle network error
  SnackBarHelper.showError(context, 'Tidak ada koneksi internet');
} on AppException catch (e) {
  // Handle general app error
  SnackBarHelper.showError(context, e.message);
} catch (e) {
  // Handle unexpected error
  SnackBarHelper.showError(context, 'Terjadi kesalahan');
}
```

---

## 🔍 Debugging Tips

### 1. View Provider State
```dart
// Add listener to provider
ref.listen(authProvider, (previous, next) {
  print('Auth state changed: $next');
});
```

### 2. Dio Logging
Already configured in `dio_client.dart` with `LogInterceptor`

### 3. Flutter DevTools
```bash
# Open DevTools
flutter pub global activate devtools
flutter pub global run devtools
```

### 4. Print Statements
```dart
import 'package:logger/logger.dart';

final logger = Logger();

logger.d('Debug message');
logger.i('Info message');
logger.w('Warning message');
logger.e('Error message', error, stackTrace);
```

---

## 🎨 Styling Guide

### Colors
```dart
// Primary colors
Theme.of(context).primaryColor          // Blue
Theme.of(context).colorScheme.secondary // Orange

// Status colors (extension)
context.statusPending                   // Orange
context.statusApproved                  // Green
context.statusRejected                  // Red
context.statusCompleted                 // Dark Green
context.statusInProgress                // Blue
context.statusCancelled                 // Grey
```

### Text Styles
```dart
Theme.of(context).textTheme.headlineLarge
Theme.of(context).textTheme.headlineMedium
Theme.of(context).textTheme.headlineSmall
Theme.of(context).textTheme.bodyLarge
Theme.of(context).textTheme.bodyMedium
Theme.of(context).textTheme.bodySmall
```

---

## 📱 Role Access Matrix

| Feature | Superadmin | Admin | Supervisor | Coordinator | Production | Maintenance |
|---------|:----------:|:-----:|:----------:|:-----------:|:----------:|:-----------:|
| Delivery Order (View) | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ |
| Delivery Order (Create/Edit) | ✅ | ✅ | ❌ | ✅ | ✅ | ❌ |
| Delivery Order (Approve) | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ |
| Inventory (View) | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ |
| Inventory (Update) | ✅ | ✅ | ❌ | ✅ | ✅ | ❌ |
| Asset (View) | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ |
| Asset (Update) | ✅ | ✅ | ❌ | ❌ | ❌ | ✅ |
| Maintenance (View) | ✅ | ✅ | ✅ | ❌ | ❌ | ✅ |
| Maintenance (Create/Edit) | ✅ | ✅ | ❌ | ❌ | ❌ | ✅ |
| Users Management | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |
| Reports | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |

---

## 🔑 Environment Variables

Create `.env` file (optional):
```env
API_BASE_URL=https://api.gaspi.com/v1
API_TIMEOUT=30000
APP_VERSION=1.0.0
```

---

## 📦 Package Versions

Check `pubspec.yaml` for current versions:
- flutter_riverpod: ^2.5.1
- go_router: ^13.0.0
- dio: ^5.4.0
- json_annotation: ^4.8.1
- intl: ^0.19.0

---

## 🐛 Common Issues & Solutions

### Issue: `.g.dart` files not found
**Solution:**
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Issue: Build failed after pub get
**Solution:**
```bash
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

### Issue: Hot reload not working
**Solution:**
```bash
# Stop app and restart
flutter run
```

### Issue: API not connecting
**Solution:**
1. Check `app_constants.dart` for correct base URL
2. Check internet connection
3. Check API server is running
4. View Dio logs in console

---

**Quick Reference Complete! 🎉**

Keep this file handy for quick lookups during development!
