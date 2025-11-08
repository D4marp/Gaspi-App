import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/gen/assets.gen.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../widgets/role_based_bottom_navigation_v2.dart';

class HomeAdminPage extends ConsumerWidget {
  const HomeAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Header Section dengan Gradient
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: screenSize.width,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.50, 0.00),
                  end: Alignment(0.50, 1.00),
                  colors: [Color(0xFF099FE4), Color(0xFF007EFF)],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left: Greeting
                      Row(
                        children: [
                          const Icon(
                            Icons.wb_sunny,
                            color: Colors.white,
                            size: 16.50,
                          ),
                          const SizedBox(width: 6),
                          Row(
                            children: [
                              const Text(
                                'Good morning, ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Nunito Sans',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                user?.name ?? 'User',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Nunito Sans',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Right: Notification
                      Container(
                        width: 38,
                        height: 38,
                        padding: const EdgeInsets.all(10),
                        decoration: ShapeDecoration(
                          color: const Color(0x260F0F0F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 3,
                              top: 3,
                              child: Container(
                                width: 5,
                                height: 5,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFE84848),
                                  shape: OvalBorder(
                                    side: const BorderSide(
                                      width: 1,
                                      color: Color(0xFF224AA3),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Main Content - Scrollable
          Positioned(
            left: 0,
            top: 140,
            right: 0,
            bottom: 96,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // Stats Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        shadows: [
                          BoxShadow(
                            color: const Color(0x19000000),
                            blurRadius: 71,
                            offset: const Offset(0, 0),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Members Stats
                          _buildStatItem(
                            icon: Assets.icons.profileCircle,
                            number: '+3',
                            label: 'Members',
                          ),
                          // Assets Stats
                          _buildStatItem(
                            icon: Assets.icons.shieldTick,
                            number: '+128',
                            label: 'Assets',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Quick Menu Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Quick Menu',
                          style: TextStyle(
                            color: Color(0xFF303030),
                            fontSize: 16,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // TODO: Navigate to all menu
                          },
                          child: const Text(
                            'See All Menu',
                            style: TextStyle(
                              color: Color(0xFF007EFF),
                              fontSize: 12,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Menu Grid - Row 1
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildMenuCard(
                          title: 'Products',
                          subtitle: 'Product\nList',
                          icon: Assets.icons.home2,
                          onTap: () {
                            // TODO: Navigate to products
                          },
                        ),
                        const SizedBox(width: 24),
                        _buildMenuCard(
                          title: 'Members',
                          subtitle: 'GWN\nMember List',
                          icon: Assets.icons.profileCircle,
                          onTap: () => context.push('/users'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Menu Grid - Row 2
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildMenuCard(
                          title: 'Reg. Assets',
                          subtitle: 'Register\nAssets',
                          icon: Assets.icons.shieldTick,
                          onTap: () {
                            // TODO: Navigate to assets registration
                          },
                        ),
                        const SizedBox(width: 24),
                        _buildMenuCard(
                          title: 'Maintenance',
                          subtitle: 'Assets\nMaintenance',
                          icon: Assets.icons.setting2,
                          onTap: () => context.push('/maintenance'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Menu Grid - Row 3
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildMenuCard(
                          title: 'User Manage',
                          subtitle: 'Administrator\n& Member',
                          icon: Assets.icons.profileCircle,
                          onTap: () => context.push('/users'),
                        ),
                        const SizedBox(width: 24),
                        _buildMenuCard(
                          title: 'Logs',
                          subtitle: 'Process\n& Activity Logs',
                          icon: Assets.icons.documentText,
                          onTap: () {
                            // TODO: Navigate to logs
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Navigation
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: RoleBasedBottomNavigationV2(
              currentRoute: '/home',
              userRole: user?.role.name ?? 'admin',
            ),
          ),
        ],
      ),
    );
  }

  /// Build individual stat item
  Widget _buildStatItem({
    required String icon,
    required String number,
    required String label,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: ShapeDecoration(
            color: const Color(0xFFB3D8FF),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: SvgPicture.asset(icon),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              number,
              style: const TextStyle(
                color: Color(0xFF393D4E),
                fontSize: 12,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w700,
                height: 1.40,
                letterSpacing: -0.24,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF68686D),
                fontSize: 12,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w400,
                height: 1.40,
                letterSpacing: -0.24,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Build individual menu card
  Widget _buildMenuCard({
    required String title,
    required String subtitle,
    required String icon,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 150.47,
          padding: const EdgeInsets.all(13.58),
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment(0.50, 0.00),
              end: Alignment(0.50, 1.00),
              colors: [Color(0xFF099FE4), Color(0xFF0372E5)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.04),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.16,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: SvgPicture.asset(
                      icon,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.19),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w400,
                      letterSpacing: -0.12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
