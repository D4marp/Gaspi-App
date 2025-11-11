import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import 'role_based_bottom_navigation.dart';

/// Wrapper untuk semua halaman dengan Navigation Bar yang tetap ada
class NavigationWrapper extends ConsumerWidget {
  final Widget child;
  final String? title;

  const NavigationWrapper({
    super.key,
    required this.child,
    this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final userRole = user?.role.value ?? 'production';
    final currentRoute = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    
    // Responsive navigation height
    final screenHeight = MediaQuery.of(context).size.height;
    final navHeight = screenHeight * 0.11;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Match page background
      body: Stack(
        clipBehavior: Clip.none, // Allow overflow for floating QR button
        children: [
          // Main Content dengan padding bawah untuk navigation
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: navHeight, // Responsive padding untuk navigation bar height
            child: SingleChildScrollView(
              child: child,
            ),
          ),

          // Bottom Navigation Bar - Fixed Position
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
