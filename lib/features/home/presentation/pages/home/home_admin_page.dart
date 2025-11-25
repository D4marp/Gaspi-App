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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return NavigationWrapper(
      title: 'Home',
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                // Header Section dengan Gradient
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.08,
                    right: screenWidth * 0.08,
                    top: screenHeight * 0.057,
                    bottom: screenWidth * 0.08,
                  ),
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
                              Icon(
                                Icons.wb_sunny,
                                color: Colors.white,
                                size: screenWidth * 0.042,
                              ),
                              SizedBox(width: screenWidth * 0.015),
                              Row(
                                children: [
                                  Text(
                                    'Good morning, ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.036,
                                      fontFamily: 'Nunito Sans',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    user?.name ?? 'User',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.036,
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
                              width: screenWidth * 0.097,
                              height: screenWidth * 0.097,
                              padding: EdgeInsets.all(screenWidth * 0.026),
                              decoration: ShapeDecoration(
                                color: const Color(0x260F0F0F),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: screenWidth * 0.008,
                                    top: screenWidth * 0.008,
                                    child: Container(
                                      width: screenWidth * 0.013,
                                      height: screenWidth * 0.013,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFE84848),
                                        shape: OvalBorder(
                                          side: BorderSide(
                                            width: 1,
                                            color: const Color(0xFF224AA3),
                                          ),
                                      ),
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.notifications_none,
                                  color: Colors.white,
                                  size: screenWidth * 0.046,
                                ),
                              ],
                            ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.038),
                    ],
                  ),
                ),

                // Main Content
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight * 0.047),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quick Menu',
                          style: TextStyle(
                            color: const Color(0xFF303030),
                            fontSize: screenWidth * 0.041,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'See All Menu',
                          style: TextStyle(
                            color: const Color(0xFF007EFF),
                            fontSize: screenWidth * 0.031,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.019),

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
                        SizedBox(width: screenWidth * 0.062),
                        _buildMenuCard(
                          title: 'Members',
                          subtitle: 'GWN\nMember List',
                          icon: Assets.icons.award,
                          onTap: () => context.go('/members'),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.028),

                    // Row 2: Reg. Assets & Maintenance
                    Row(
                      children: [
                        _buildMenuCard(
                          title: 'Reg. Assets',
                          subtitle: 'Register\nAssets',
                          icon: Assets.icons.shieldTickBold,
                          onTap: () => context.go('/assets-registration'),
                        ),
                        SizedBox(width: screenWidth * 0.062),
                        _buildMenuCard(
                          title: 'Maintenance',
                          subtitle: 'Assets\nMaintenance',
                          icon: Assets.icons.setting2,
                          onTap: () => context.go('/maintenance'),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.028),

                    // Row 3: User Manage & Logs
                    Row(
                      children: [
                        _buildMenuCard(
                          title: 'User Manage',
                          subtitle: 'Administrator\n& Member',
                          icon: Assets.icons.people,
                          onTap: () => context.go('/user-management'),
                        ),
                        SizedBox(width: screenWidth * 0.062),
                        _buildMenuCard(
                          title: 'Logs',
                          subtitle: 'Process\n& Activity Logs',
                          icon: Assets.icons.stickynote,
                          onTap: () => context.go('/logs'),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.15),
                  ],
                ),
              ),
            ],
          ),
          
          // Stats Card - Positioned between gradient and content (overlapping)
          Positioned(
            left: screenWidth * 0.083,
            top: screenHeight * 0.133,
            right: screenWidth * 0.083,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.062,
                vertical: screenHeight * 0.014,
              ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Members Stats
                  _buildStatItem(
                    icon: Assets.icons.award,
                    number: '+3',
                    label: 'Members',
                  ),

                  // Assets Stats
                  _buildStatItem(
                    icon: Assets.icons.mdiGasCylinder,
                    number: '+128',
                    label: 'Assets',
                  ),
                ],
              ),
            ),
          ),],
      ),
      ),
    );
  }

  /// Build individual stat item
  Widget _buildStatItem({
    required String icon,
    required String number,
    required String label,
  }) {
    return Builder(
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;
        
        return Row(
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.021),
              decoration: ShapeDecoration(
                color: const Color(0xFFB3D8FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: SvgPicture.asset(
                icon,
                width: screenWidth * 0.051,
                height: screenWidth * 0.051,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF007EFF),
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.031),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  number,
                  style: TextStyle(
                    color: const Color(0xFF393D4E),
                    fontSize: screenWidth * 0.031,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w700,
                    height: 1.40,
                    letterSpacing: -0.24,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    color: const Color(0xFF68686D),
                    fontSize: screenWidth * 0.031,
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
      },
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
        child: Builder(
          builder: (context) {
            final screenWidth = MediaQuery.of(context).size.width;
            final screenHeight = MediaQuery.of(context).size.height;
            
            return Container(
              height: screenHeight * 0.178,
              padding: EdgeInsets.all(screenWidth * 0.035),
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
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.041,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.16,
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        icon,
                        width: screenWidth * 0.072,
                        height: screenWidth * 0.072,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.021),
                      Expanded(
                        child: Text(
                          subtitle,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.031,
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
            );
          },
        ),
      ),
    );
  }
}
