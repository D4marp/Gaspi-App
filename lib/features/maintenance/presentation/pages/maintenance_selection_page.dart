import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaspi_app/core/gen/assets.gen.dart';
import 'package:gaspi_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:gaspi_app/features/home/presentation/widgets/role_based_bottom_navigation.dart';
import 'package:go_router/go_router.dart';

class MaintenanceSelectionPage extends ConsumerWidget {
  const MaintenanceSelectionPage({super.key});

  double _sw(BuildContext c, double px) => px / 390 * MediaQuery.of(c).size.width;
  double _sh(BuildContext c, double px) => px / 844 * MediaQuery.of(c).size.height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final userRole = user?.role.value ?? 'production';
    final currentRoute = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Main content
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      top: _sh(context, 48),
                      left: _sw(context, 32),
                      right: _sw(context, 32),
                      bottom: _sh(context, 20),
                    ),
                    color: Colors.white,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: _sw(context, 12),
                      children: [
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            size: _sw(context, 24),
                            color: const Color(0xFF191D0B),
                          ),
                        ),
                        Text(
                          'Maintenance',
                          style: TextStyle(
                            color: const Color(0xFF191D0B),
                            fontSize: _sw(context, 16),
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w700,
                            height: 1.10,
                            letterSpacing: -0.32,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Selection Cards
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: _sw(context, 32),
                      vertical: _sh(context, 40),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Maintenance Type',
                          style: TextStyle(
                            color: const Color(0xFF101828),
                            fontSize: _sw(context, 20),
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w700,
                            height: 1.20,
                            letterSpacing: -0.60,
                          ),
                        ),
                        SizedBox(height: _sh(context, 24)),

                        // Cylinder Maintenance Card
                        _MaintenanceCardWidget(
                          icon: Assets.icons.mdiGasCylinder,
                          title: 'Cylinder Maintenance',
                          description: 'Manage gas cylinder maintenance and inspections',
                          onTap: () => context.go('/maintenance/cylinder'),
                        ),
                        SizedBox(height: _sh(context, 16)),

                        // Transport Rack Maintenance Card
                        _MaintenanceCardWidget(
                          icon: Assets.icons.truckFast,
                          title: 'Transport Rack Maintenance',
                          description: 'Manage transport rack maintenance and safety checks',
                          onTap: () => context.go('/maintenance/transport-rack'),
                        ),
                        SizedBox(height: _sh(context, 16)),

                        // Manifold Maintenance Card
                        _MaintenanceCardWidget(
                          icon: Assets.icons.convert3dCube,
                          title: 'Manifold Maintenance',
                          description: 'Manage manifold maintenance and inspections',
                          onTap: () => context.go('/maintenance/manifold'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: _sh(context, 20)),
                ],
              ),
            ),
          ),

          // Bottom navigation
          RoleBasedBottomNavigation(
            currentRoute: currentRoute,
            userRole: userRole,
          ),
        ],
      ),
    );
  }
}

/// Maintenance Card Widget
class _MaintenanceCardWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _MaintenanceCardWidget({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double sw(double px) => px / 390 * screenWidth;
    double sh(double px) => px / 844 * screenHeight;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(sw(20)),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(
              width: 1,
              color: Color(0xFFEDEDED),
            ),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 71,
              offset: Offset(0, 0),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              padding: EdgeInsets.all(sw(12)),
              decoration: ShapeDecoration(
                color: const Color(0xFFB3D8FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: SvgPicture.asset(
                icon,
                width: sw(32),
                height: sw(32),
                colorFilter: const ColorFilter.mode(
                  Color(0xFF007EFF),
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(width: sw(16)),

            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: const Color(0xFF101828),
                      fontSize: sw(14),
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w700,
                      height: 1.20,
                      letterSpacing: -0.28,
                    ),
                  ),
                  SizedBox(height: sh(4)),
                  Text(
                    description,
                    style: TextStyle(
                      color: const Color(0xFF68686D),
                      fontSize: sw(12),
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w400,
                      height: 1.40,
                      letterSpacing: -0.24,
                    ),
                  ),
                ],
              ),
            ),

            // Arrow icon
            SizedBox(width: sw(8)),
            Icon(
              Icons.arrow_forward_ios,
              size: sw(16),
              color: const Color(0xFF007EFF),
            ),
          ],
        ),
      ),
    );
  }
}