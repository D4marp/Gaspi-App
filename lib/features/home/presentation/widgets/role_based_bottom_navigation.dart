import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/gen/assets.gen.dart';

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

    return Container(
      width: screenWidth,
      height: 96,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0x19000000),
            blurRadius: 78,
            offset: const Offset(0, -11),
            spreadRadius: 0,
          )
        ],
      ),
      child: Stack(
        children: [
          // Background Navigation Bar - Full Width
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              width: screenWidth,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 47,
                    offset: Offset(0, -11),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                  navItems.length,
                  (index) => _buildNavItem(
                    context,
                    navItems[index],
                    isActive: currentRoute == navItems[index].route,
                  ),
                ),
              ),
            ),
          ),

          // Floating QR Button (Centered at top)
          Positioned(
            left: 0,
            right: 0,
            top: -15,
            child: Center(
              child: GestureDetector(
                onTap: () => context.go('/qr-scan'),
                child: Container(
                  width: 66,
                  height: 66,
                  decoration: BoxDecoration(
                    color: const Color(0xFF007EFF),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF007EFF).withOpacity(0.35),
                        blurRadius: 22,
                        offset: const Offset(0, 0),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: SvgPicture.asset(
                    Assets.icons.qr,
                    width: 32,
                    height: 32,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
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
  }) {
    return GestureDetector(
      onTap: () => context.go(item.route),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            item.icon,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              isActive ? const Color(0xFF007EFF) : const Color(0xCC777985),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            item.label,
            style: TextStyle(
              color: isActive ? const Color(0xFF007EFF) : const Color(0xCC777985),
              fontSize: 10,
              fontFamily: 'Nunito Sans',
              fontWeight: FontWeight.w600,
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
