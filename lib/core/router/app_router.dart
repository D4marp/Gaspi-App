import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/reset_password_page.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/delivery_order/presentation/pages/delivery_order_page.dart';
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

      // Jika belum login dan bukan di splash/login page, redirect ke login
      if (!isAuthenticated && !isLoggingIn && !isSplash) {
        return '/login';
      }

      // Jika sudah login dan masih di login page, redirect ke home
      if (isAuthenticated && isLoggingIn) {
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
        builder: (context, state) => const HomePage(),
      ),

      // Delivery Order Routes
      GoRoute(
        path: '/delivery-orders',
        builder: (context, state) => const DeliveryOrderPage(),
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

/// Home Page / Dashboard
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gaspi Mobile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authProvider.notifier).logout();
              if (context.mounted) {
                context.go('/login');
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat Datang,',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user?.name ?? 'User',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        user?.role.displayName ?? 'User',
                        style: const TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Menu Grid
            Text(
              'Menu Utama',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  if (user?.role.hasPermission('delivery_order', 'view') ?? false)
                    _MenuCard(
                      icon: Icons.local_shipping,
                      title: 'Delivery Order',
                      color: AppTheme.primaryColor,
                      onTap: () => context.push('/delivery-orders'),
                    ),
                  if (user?.role.hasPermission('inventory', 'view') ?? false)
                    _MenuCard(
                      icon: Icons.inventory_2,
                      title: 'Inventory',
                      color: AppTheme.secondaryColor,
                      onTap: () {
                        // TODO: Navigate to inventory
                      },
                    ),
                  if (user?.role.hasPermission('asset', 'view') ?? false)
                    _MenuCard(
                      icon: Icons.devices_other,
                      title: 'Asset Tracking',
                      color: AppTheme.warningColor,
                      onTap: () {
                        // TODO: Navigate to asset
                      },
                    ),
                  if (user?.role.hasPermission('maintenance', 'view') ?? false)
                    _MenuCard(
                      icon: Icons.build,
                      title: 'Maintenance',
                      color: AppTheme.tertiaryColor,
                      onTap: () => context.push('/maintenance'),
                    ),
                  if (user?.role.isAdmin ?? false)
                    _MenuCard(
                      icon: Icons.people,
                      title: 'Users',
                      color: AppTheme.infoColor,
                      onTap: () => context.push('/users'),
                    ),
                  _MenuCard(
                    icon: Icons.assessment,
                    title: 'Reports',
                    color: AppTheme.successColor,
                    onTap: () {
                      // TODO: Navigate to reports
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
