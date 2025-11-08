# Navigation Page Checklist

## Status Implementasi Navigation di Setiap Halaman

### Auth Feature
- [x] **SplashPage** (`splash_page.dart`) - Navigation sudah ada
- [x] **OnboardingPage** (`onboarding_page.dart`) - Navigation sudah ada  
- [x] **LoginPage** (`login_page.dart`) - Navigation sudah ada
- [x] **ResetPasswordPage** (`reset_password_page.dart`) - Navigation sudah ada

### Home Feature
- [x] **HomeAdminPage** (`home_admin_page.dart`) - Navigation sudah ada (RoleBasedBottomNavigationV2)
- [ ] **PartnershipOpportunityPage** (`partnership_opportunity_page.dart`) - Perlu ditambahkan

### Profile Feature
- [x] **ProfilePage** (`profile_page.dart`) - Navigation sudah ditambahkan

### Maintenance Feature
- [x] **MaintenancePage** (`maintenance_page.dart`) - Navigation sudah ditambahkan

### Delivery Order Feature
- [ ] **DeliveryOrderPage** (`delivery_order_page.dart`) - Perlu ditambahkan

## Template Standard untuk Navigation Page

Setiap halaman harus memiliki struktur berikut:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../home/presentation/widgets/role_based_bottom_navigation.dart';

class [PageName] extends ConsumerWidget {
  const [PageName]({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final userRole = user?.role.value ?? 'production';
    final currentRoute = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    return Scaffold(
      body: Stack(
        children: [
          // Main Content dengan SafeArea
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    const Text(
                      '[Page Title]',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Page Content di sini
                  ],
                ),
              ),
            ),
          ),

          // Bottom Navigation (Fixed di bawah)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: RoleBasedBottomNavigation(
              currentRoute: currentRoute,
              userRole: userRole,
            ),
          ),
        ],
      ),
    );
  }
}
```

## Catatan Penting

1. **Stack + Positioned**: Gunakan Stack untuk menumpuk main content dengan bottom navigation
2. **RoleBasedBottomNavigation**: Gunakan widget navigation dari `home/presentation/widgets/role_based_bottom_navigation.dart`
3. **userRole**: Ambil dari `user?.role.value ?? 'production'` untuk compatibility dengan NavigationBottom
4. **currentRoute**: Ambil dari GoRouter untuk tracking route aktif
5. **SafeArea + SingleChildScrollView**: Untuk menghindari overlap dengan notch dan navigation bottom

## Checklist Implementasi

Sebelum push, pastikan setiap page memiliki:
- ✅ RoleBasedBottomNavigation widget
- ✅ Proper imports untuk Riverpod dan GoRouter  
- ✅ currentUserProvider dari auth_provider
- ✅ SafeArea untuk padding aman
- ✅ Stack layout untuk positioning navigation

## Routes yang Harus Didukung Navigation

Setiap navigation item mengarah ke:
- `/home` - HomeAdminPage
- `/assets-registration` - Assets Registration (untuk admin)
- `/qr-scan` - QR Scan
- `/maintenance-tasks` atau `/maintenance` - Maintenance
- `/account` - ProfilePage

