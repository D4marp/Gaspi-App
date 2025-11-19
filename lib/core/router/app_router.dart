import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/reset_password_page.dart';
import '../../features/auth/presentation/pages/onboarding_page.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/account/presentation/pages/account_page.dart';
import '../../features/account/presentation/pages/edit_account_page.dart';
import '../../features/delivery_order/presentation/pages/delivery_order_page.dart';
import '../../features/home/presentation/pages/home/home_admin_page.dart';
import '../../features/home/presentation/pages/partnership/partnership_opportunity_page.dart';
import '../../features/home/presentation/pages/notification/notification_page.dart';
import '../../features/home/presentation/pages/products/products_page.dart';
import '../../features/home/presentation/pages/members/members_page.dart';
import '../../features/home/presentation/pages/members/member_detail_page.dart';
import '../../features/home/presentation/pages/members/add_member_page.dart';
import '../../features/home/presentation/pages/members/edit_member_page.dart';
import '../../features/home/presentation/pages/reg_assets/assets_registration_page.dart';
import '../../features/home/presentation/pages/reg_assets/asset_detail_page.dart';
import '../../features/home/presentation/widgets/navigation_wrapper.dart';
import '../../features/logs/presentation/pages/activity_logs_page.dart';
import '../../features/maintenance/presentation/pages/maintenance_cylinder_page.dart';
import '../../features/maintenance/presentation/pages/maintenance_transport_rack_page.dart';
import '../../features/maintenance/presentation/pages/maintenance_manifold_page.dart';
import '../../features/maintenance/presentation/pages/maintenance_selection_page.dart';
import '../../features/qr_scanner/presentation/pages/qr_scan_page.dart';
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

      // Products Route
      GoRoute(
        path: '/products',
        builder: (context, state) => const ProductsPage(),
      ),

      // Members Routes
      GoRoute(
        path: '/members',
        builder: (context, state) => const MembersPage(),
      ),

      GoRoute(
        path: '/member-detail',
        builder: (context, state) => const MemberDetailPage(),
      ),

      GoRoute(
        path: '/add-member',
        builder: (context, state) => const AddMemberPage(),
      ),

      GoRoute(
        path: '/edit-member/:memberId',
        builder: (context, state) {
          final memberId = state.pathParameters['memberId'] ?? '';
          return EditMemberPage(memberId: memberId);
        },
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

      // Maintenance Routes
      GoRoute(
        path: '/maintenance',
        builder: (context, state) => const MaintenanceSelectionPage(),
      ),

      GoRoute(
        path: '/maintenance/cylinder',
        builder: (context, state) => const MaintenanceCylinderPage(),
      ),

      GoRoute(
        path: '/maintenance/transport-rack',
        builder: (context, state) => const MaintenanceTransportRackPage(),
      ),

      GoRoute(
        path: '/maintenance/manifold',
        builder: (context, state) => const MaintenanceManifoldPage(),
      ),

      // Activity Logs Route
      GoRoute(
        path: '/logs',
        builder: (context, state) => const ActivityLogsPage(),
      ),

      // Assets Registration Route
      GoRoute(
        path: '/assets-registration',
        builder: (context, state) => const AssetsRegistrationPage(),
      ),

      // Asset Detail Route
      GoRoute(
        path: '/asset-detail/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return AssetDetailPage(assetId: id);
        },
      ),

      // QR Scan Route
      GoRoute(
        path: '/qr-scan',
        builder: (context, state) => const QrScanPage(),
      ),

            // Account Route
      GoRoute(
        path: '/account',
        builder: (context, state) => const AccountPage(),
        routes: [
          GoRoute(
            path: 'edit',
            builder: (context, state) => const EditAccountPage(),
          ),
        ],
      ),

      // Notification Route
      GoRoute(
        path: '/notification',
        builder: (context, state) => const NotificationPage(),
      ),

      // Supervisor Report Route
      GoRoute(
        path: '/supervisor-report',
        builder: (context, state) => const SupervisorReportPage(),
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

/// Placeholder pages dengan NavigationWrapper
class SupervisorReportPage extends ConsumerWidget {
  const SupervisorReportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationWrapper(
      title: 'Supervisor Report',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assessment_outlined, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Supervisor Report - Coming Soon',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

class UsersPage extends ConsumerWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationWrapper(
      title: 'Users Management',
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_outline, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Users Management - Coming Soon',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

class UnauthorizedPage extends ConsumerWidget {
  const UnauthorizedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
