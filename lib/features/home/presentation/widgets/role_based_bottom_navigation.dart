import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/gen/assets.gen.dart';
import 'bottom_nav_clipper.dart';

/// Bottom Navigation Menu berdasarkan Role - Full Width dengan QR Center
class RoleBasedBottomNavigation extends StatelessWidget {
  final String currentRoute;
  final String userRole; // 'SUPERADMIN', 'ADMIN', 'MAINTENANCE', 'SUPERVISOR', 'PRODUCTION'

  const RoleBasedBottomNavigation({
    super.key,
    required this.currentRoute,
    required this.userRole,
  });

  List<NavItem> _getNavItems() {
    switch (userRole.toUpperCase()) {
      case 'SUPERADMIN':
      case 'ADMIN':
        return _getAdminItems();
      case 'MAINTENANCE':
        return _getMaintenanceItems();
      case 'SUPERVISOR':
      case 'PRODUCTION':
        return _getSupervisorItems();
      default:
        return _getAdminItems();
    }
  }

  List<NavItem> _getAdminItems() {
    return [
      NavItem(
        label: 'Home',
        icon: Assets.icons.home2,
        route: '/home',
      ),
      NavItem(
        label: 'Reg. Assets',
        icon: Assets.icons.shieldTick,
        route: '/assets-registration',
      ),
      NavItem(
        label: 'Maintenance',
        icon: Assets.icons.setting2,
        route: '/maintenance',
      ),
      NavItem(
        label: 'Account',
        icon: Assets.icons.profileCircle,
        route: '/account',
      ),
    ];
  }

  List<NavItem> _getMaintenanceItems() {
    return [
      NavItem(
        label: 'Home',
        icon: Assets.icons.home2,
        route: '/home',
      ),
      NavItem(
        label: 'Tasks',
        icon: Assets.icons.task,
        route: '/maintenance-tasks',
      ),
      NavItem(
        label: 'Schedule',
        icon: Assets.icons.documentText,
        route: '/maintenance-schedule',
      ),
      NavItem(
        label: 'Account',
        icon: Assets.icons.profileCircle,
        route: '/account',
      ),
    ];
  }

  List<NavItem> _getSupervisorItems() {
    return [
      NavItem(
        label: 'Home',
        icon: Assets.icons.home2,
        route: '/home',
      ),
      NavItem(
        label: 'Report',
        icon: Assets.icons.documentText,
        route: '/supervisor-report',
      ),
      NavItem(
        label: 'QR Scan',
        icon: Assets.icons.qr,
        route: '/qr-scan',
      ),
      NavItem(
        label: 'Account',
        icon: Assets.icons.profileCircle,
        route: '/account',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final navItems = _getNavItems();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    // Responsive sizes based on screen width
    final navHeight = screenHeight * 0.11; // 11% of screen height
    final qrSize = screenWidth * 0.25; // 28% of screen width (lebih besar)
    final iconSize = screenWidth * 0.060; // 6.5% of screen width
    final fontSize = screenWidth * 0.023; // 2.7% of screen width

    return SizedBox(
      height: navHeight,
      child: Stack(
        clipBehavior: Clip.none, // Allow overflow for floating button
        children: [
        // Navigation bar dengan notch
        ClipPath(
          clipper: BottomNavClipper(),
          child: Container(
            width: screenWidth,
            height: navHeight,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.08, // 8% of screen width (lebih besar)
                vertical: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left items
                  if (navItems.isNotEmpty)
                    _buildNavItem(
                      context,
                      navItems[0],
                      isActive: currentRoute == navItems[0].route,
                      iconSize: iconSize,
                      fontSize: fontSize,
                    ),
                  if (navItems.length > 1)
                    _buildNavItem(
                      context,
                      navItems[1],
                      isActive: currentRoute == navItems[1].route,
                      iconSize: iconSize,
                      fontSize: fontSize,
                    ),
                  
                  // Space for QR button
                  SizedBox(width: qrSize),
                  
                  // Right items
                  if (navItems.length > 2)
                    _buildNavItem(
                      context,
                      navItems[2],
                      isActive: currentRoute == navItems[2].route,
                      iconSize: iconSize,
                      fontSize: fontSize,
                    ),
                  if (navItems.length > 3)
                    _buildNavItem(
                      context,
                      navItems[3],
                      isActive: currentRoute == navItems[3].route,
                      iconSize: iconSize,
                      fontSize: fontSize,
                    ),
                ],
              ),
            ),
          ),
        ),
        
        // Floating QR Button - Responsive size with expanded hit area
        Positioned(
          left: 0,
          right: 0,
          top: -(qrSize * 0.8), // Reduced from 0.6 to 0.4 - not too high
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  debugPrint('QR Button tapped! Navigating to /qr-scan');
                  context.go('/qr-scan');
                },
                borderRadius: BorderRadius.circular(qrSize / 2),
                splashColor: Colors.blue.withValues(alpha: 0.3),
                highlightColor: Colors.blue.withValues(alpha: 0.1),
                child: Container(
                  width: qrSize + 30, // More padding for easier tap
                  height: qrSize + 30,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(qrSize / 2),
                    // Semi-transparent background for debugging (remove later)
                    color: Colors.red.withValues(alpha: 0.0),
                  ),
                  child: SvgPicture.asset(
                    Assets.icons.qr,
                    width: qrSize,
                    height: qrSize,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    NavItem item, {
    required bool isActive,
    required double iconSize,
    required double fontSize,
  }) {
    return GestureDetector(
      onTap: () => context.go(item.route),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            item.icon,
            width: iconSize,
            height: iconSize,
            colorFilter: ColorFilter.mode(
              isActive ? const Color(0xFF007EFF) : const Color(0xCC777985),
              BlendMode.srcIn,
            ),
          ),
          SizedBox(height: fontSize * 0.4),
          Text(
            item.label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isActive ? const Color(0xFF007EFF) : const Color(0xCC777985),
              fontSize: fontSize,
              fontFamily: 'Nunito Sans',
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
              height: 1.20,
            ),
          ),
        ],
      ),
    );
  }
}

/// Model untuk Navigation Item
class NavItem {
  final String label;
  final String icon;
  final String route;

  NavItem({
    required this.label,
    required this.icon,
    required this.route,
  });
}
