import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaspi_app/core/gen/assets.gen.dart';
import 'package:gaspi_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:gaspi_app/features/home/presentation/widgets/navigation_wrapper.dart';
import 'package:go_router/go_router.dart';

class HomeAdminPage extends ConsumerWidget {
  const HomeAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return NavigationWrapper(
      title: 'Home',
      child: Stack(
        children: [
          Column(
            children: [
              // Header Section dengan Gradient
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 32, right: 32, top: 48, bottom: 32),
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
                        GestureDetector(
                          onTap: () => context.push('/notification'),
                          child: Container(
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
                              const Icon(
                                Icons.notifications_none,
                                color: Colors.white,
                                size: 18,
                              ),
                            ],
                          ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32), // Reduced space for stats card
                  ],
                ),
              ),

              // Main Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40), // Space for stats card overlap
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
                      Text(
                        'See All Menu',
                        style: TextStyle(
                          color: const Color(0xFF007EFF),
                          fontSize: 12,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Quick Actions Grid - 3 Rows x 2 Columns
                  // Row 1: Products & Members
                  Row(
                    children: [
                      _buildMenuCard(
                        title: 'Products',
                        subtitle: 'Product\nList',
                        icon: Assets.icons.box,
                        onTap: () => context.go('/products'),
                      ),
                      const SizedBox(width: 24),
                      _buildMenuCard(
                        title: 'Members',
                        subtitle: 'GWN\nMember List',
                        icon: Assets.icons.award,
                        onTap: () => context.go('/members'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Row 2: Reg. Assets & Maintenance
                  Row(
                    children: [
                      _buildMenuCard(
                        title: 'Reg. Assets',
                        subtitle: 'Register\nAssets',
                        icon: Assets.icons.shieldTickBold,
                        onTap: () => context.go('/assets-registration'),
                      ),
                      const SizedBox(width: 24),
                      _buildMenuCard(
                        title: 'Maintenance',
                        subtitle: 'Assets\nMaintenance',
                        icon: Assets.icons.setting2,
                        onTap: () => context.go('/maintenance'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Row 3: User Manage & Logs
                  Row(
                    children: [
                      _buildMenuCard(
                        title: 'User Manage',
                        subtitle: 'Administrator\n& Member',
                        icon: Assets.icons.people,
                        onTap: () => context.go('/users'),
                      ),
                      const SizedBox(width: 24),
                      _buildMenuCard(
                        title: 'Logs',
                        subtitle: 'Process\n& Activity Logs',
                        icon: Assets.icons.stickynote,
                        onTap: () => context.go('/logs'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 80), // Bottom padding for nav
                ],
              ),
            ),
          ],
        ),
        
        // Stats Card - Positioned between gradient and content (overlapping)
        Positioned(
          left: 32.50,
          top: 112, // Adjusted position after reducing gradient padding
          right: 32.50,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 71,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Row(
              children: [
                // Members Stats
                _buildStatItem(
                  icon: Assets.icons.award,
                  number: '+3',
                  label: 'Members',
                ),
                const SizedBox(width: 39),
                // Assets Stats
                _buildStatItem(
                  icon: Assets.icons.mdiGasCylinder,
                  number: '+128',
                  label: 'Assets',
                ),
              ],
            ),
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: SvgPicture.asset(
            icon,
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(
              Color(0xFF007EFF),
              BlendMode.srcIn,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
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

  /// Build menu card (new design)
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
                children: [
                  SvgPicture.asset(
                    icon,
                    width: 28,
                    height: 28,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 8.19),
                  Expanded(
                    child: Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.12,
                      ),
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
