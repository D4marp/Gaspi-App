import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/reset_password_page.dart';
import '../../features/auth/presentation/pages/onboarding_page.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/delivery_order/presentation/pages/delivery_order_page.dart';
import '../../features/home/presentation/pages/home_admin_page.dart';
import '../../features/home/presentation/pages/partnership_opportunity_page.dart';
import '../theme/app_theme.dart';

/// Router Provider dengan RBAC
final routerProvider = Provider<GoRouter>((ref) {
  final isAuthenticated = ref.watch(isAuthenticatedProvider);
  final currentUser = ref.watch(currentUserProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final isSplash = state.matchedLocation == '/splash';
      final isLoggingIn = state.matchedLocation == '/login';
      final isForgotPassword = state.matchedLocation == '/forgot-password';
      final isOnboarding = state.matchedLocation == '/onboarding';

      // Jika belum login dan bukan di splash/login/forgot-password/onboarding page, redirect ke login
      if (!isAuthenticated && !isLoggingIn && !isSplash && !isForgotPassword && !isOnboarding) {
        return '/login';
      }

      // Jika sudah login dan masih di login page, redirect ke home
      if (isAuthenticated && isLoggingIn) {
        return '/home';
      }

      // Jika sudah login dan masih di forgot-password page, redirect ke home
      if (isAuthenticated && isForgotPassword) {
        return '/home';
      }

      // Jika sudah login dan masih di onboarding page, redirect ke home
      if (isAuthenticated && isOnboarding) {
        return '/home';
      }

      // Check role-based access
      if (isAuthenticated && currentUser != null) {
        final location = state.matchedLocation;

        // Contoh: hanya role tertentu yang bisa akses maintenance
        if (location.startsWith('/maintenance')) {
          if (!currentUser.role.hasPermission('maintenance', 'view')) {
            return '/unauthorized';
          }
        }

        // Contoh: hanya admin & superadmin yang bisa akses users
        if (location.startsWith('/users')) {
          if (!currentUser.role.isAdmin) {
            return '/unauthorized';
          }
        }
      }

      return null; // Tidak ada redirect
    },
    routes: [
      // Splash Screen
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),

      // Onboarding Screen
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),

      // Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),

      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => ResetPasswordPage(
          email: state.extra as String?,
        ),
      ),

      // Home/Dashboard Route
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeAdminPage(),
      ),

      // Delivery Order Routes
      GoRoute(
        path: '/delivery-orders',
        builder: (context, state) => const DeliveryOrderPage(),
      ),

      // Partnership Opportunity Route
      GoRoute(
        path: '/partnership-opportunity',
        builder: (context, state) => const PartnershipOpportunityPage(),
      ),

      // Maintenance Routes (example)
      GoRoute(
        path: '/maintenance',
        builder: (context, state) => const MaintenancePage(),
      ),

      // Users Management (admin only)
      GoRoute(
        path: '/users',
        builder: (context, state) => const UsersPage(),
      ),

      // Unauthorized Page
      GoRoute(
        path: '/unauthorized',
        builder: (context, state) => const UnauthorizedPage(),
      ),
    ],
  );
});

/// Placeholder pages
class MaintenancePage extends StatelessWidget {
  const MaintenancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Maintenance')),
      body: const Center(child: Text('Maintenance Page - Coming Soon')),
    );
  }
}

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users Management')),
      body: const Center(child: Text('Users Page - Coming Soon')),
    );
  }
}

class UnauthorizedPage extends StatelessWidget {
  const UnauthorizedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Akses Ditolak')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lock_outline, size: 64, color: AppTheme.errorColor),
            const SizedBox(height: 16),
            Text(
              'Anda tidak memiliki akses ke halaman ini',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('Kembali ke Home'),
            ),
          ],
        ),
      ),
    );
  }
}
