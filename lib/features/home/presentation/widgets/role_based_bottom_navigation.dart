import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/gen/assets.gen.dart';

/// Bottom Navigation Menu berdasarkan Role
class RoleBasedBottomNavigation extends StatelessWidget {
  final String currentRoute;
  final String userRole; // 'super_admin', 'admin', 'maintenance', 'supervisor'

  const RoleBasedBottomNavigation({
    super.key,
    required this.currentRoute,
    required this.userRole,
  });

  List<NavItem> _getNavItems() {
    switch (userRole.toLowerCase()) {
      case 'super_admin':
        return _getSuperAdminItems();
      case 'admin':
        return _getAdminItems();
      case 'maintenance':
        return _getMaintenanceItems();
      case 'supervisor':
      case 'production':
        return _getSupervisorItems();
      default:
        return _getAdminItems(); // Default to admin
    }
  }

  List<NavItem> _getSuperAdminItems() {
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
        label: 'QR Scan',
        icon: Assets.icons.qr,
        route: '/qr-scan',
      ),
      NavItem(
        label: 'Report',
        icon: Assets.icons.documentText,
        route: '/supervisor-report',
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

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0x19000000),
            blurRadius: 78,
            offset: const Offset(0, -11),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Stack(
        children: [
          /// Background with rounded top
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 90,
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
            ),
          ),

          /// Navigation items
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 90,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

          /// Floating center button (QR icon)
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Center(
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
        children: [
          /// Icon
          SvgPicture.asset(
            item.icon,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              isActive ? const Color(0xFF007EFF) : const Color(0xCC777985),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 12),

          /// Label
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
  final String icon; // SVG path
  final String route;

  NavItem({
    required this.label,
    required this.icon,
    required this.route,
  });
}
