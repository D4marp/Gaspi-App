import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/gen/assets.gen.dart';
import 'search_modal.dart';

/// Bottom Navigation Menu berdasarkan Role - Design Baru
class RoleBasedBottomNavigationV2 extends StatelessWidget {
  final String currentRoute;
  final String userRole; // 'super_admin', 'admin', 'maintenance', 'supervisor'

  const RoleBasedBottomNavigationV2({
    super.key,
    required this.currentRoute,
    required this.userRole,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth,
      height: 134,
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
          // Bottom navigation bar
          Positioned(
            left: 0,
            right: 0,
            top: 38,
            child: Container(
              width: screenWidth,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                shadows: [
                  BoxShadow(
                    color: const Color(0x19000000),
                    blurRadius: 47,
                    offset: const Offset(0, -11),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Item 1
                  SizedBox(
                    width: 60,
                    child: _buildNavItem(
                      icon: Assets.icons.home2,
                      label: 'Home',
                      isActive: currentRoute == '/home',
                      onTap: () => context.go('/home'),
                    ),
                  ),
                  const SizedBox(width: 32),
                  // Item 2
                  SizedBox(
                    width: 60,
                    child: _buildNavItem(
                      icon: _getSecondItemIcon(),
                      label: _getSecondItemLabel(),
                      isActive: currentRoute == _getSecondItemRoute(),
                      onTap: () => context.go(_getSecondItemRoute()),
                    ),
                  ),
                  // Spacer for QR button
                  const Spacer(),
                  // Item 3
                  SizedBox(
                    width: 60,
                    child: _buildNavItem(
                      icon: _getThirdItemIcon(),
                      label: _getThirdItemLabel(),
                      isActive: currentRoute == _getThirdItemRoute(),
                      onTap: () => context.go(_getThirdItemRoute()),
                    ),
                  ),
                  const SizedBox(width: 32),
                  // Item 4
                  SizedBox(
                    width: 60,
                    child: _buildNavItem(
                      icon: Assets.icons.profileCircle,
                      label: 'Account',
                      isActive: currentRoute == '/account',
                      onTap: () => context.go('/account'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Floating QR/Search button
          Positioned(
            left: (screenWidth / 2) - 33.19,
            top: 0,
            child: GestureDetector(
              onTap: () => _handleCenterButtonTap(context),
              child: Container(
                width: 66.39,
                height: 66.39,
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  color: const Color(0xFF007EFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  shadows: [
                    BoxShadow(
                      color: const Color(0x59598CFF),
                      blurRadius: 22,
                      offset: const Offset(0, 0),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: SvgPicture.asset(
                  _getCenterButtonIcon(),
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

  /// Build individual nav item
  Widget _buildNavItem({
    required String icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(
                isActive ? const Color(0xFF007EFF) : const Color(0xCC777985),
                BlendMode.srcIn,
              ),
            ),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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

  /// Get second item based on role
  String _getSecondItemIcon() {
    switch (userRole.toLowerCase()) {
      case 'super_admin':
      case 'admin':
        return Assets.icons.shieldTick;
      case 'maintenance':
        return Assets.icons.task;
      case 'supervisor':
      case 'production':
        return Assets.icons.qr;
      default:
        return Assets.icons.shieldTick;
    }
  }

  String _getSecondItemLabel() {
    switch (userRole.toLowerCase()) {
      case 'super_admin':
      case 'admin':
        return 'Reg. Assets';
      case 'maintenance':
        return 'Tasks';
      case 'supervisor':
      case 'production':
        return 'QR Scan';
      default:
        return 'Reg. Assets';
    }
  }

  String _getSecondItemRoute() {
    switch (userRole.toLowerCase()) {
      case 'super_admin':
      case 'admin':
        return '/assets-registration';
      case 'maintenance':
        return '/maintenance-tasks';
      case 'supervisor':
      case 'production':
        return '/qr-scan';
      default:
        return '/assets-registration';
    }
  }

  /// Get third item based on role
  String _getThirdItemIcon() {
    switch (userRole.toLowerCase()) {
      case 'super_admin':
      case 'admin':
        return Assets.icons.setting2;
      case 'maintenance':
        return Assets.icons.setting2;
      case 'supervisor':
      case 'production':
        return Assets.icons.documentText;
      default:
        return Assets.icons.setting2;
    }
  }

  String _getThirdItemLabel() {
    switch (userRole.toLowerCase()) {
      case 'super_admin':
      case 'admin':
        return 'Maintenance';
      case 'maintenance':
        return 'Schedule';
      case 'supervisor':
      case 'production':
        return 'Report';
      default:
        return 'Maintenance';
    }
  }

  String _getThirdItemRoute() {
    switch (userRole.toLowerCase()) {
      case 'super_admin':
      case 'admin':
        return '/maintenance';
      case 'maintenance':
        return '/maintenance-schedule';
      case 'supervisor':
      case 'production':
        return '/supervisor-report';
      default:
        return '/maintenance';
    }
  }

  /// Get center button icon (QR or Search)
  String _getCenterButtonIcon() {
    // Show QR icon for these routes (HOME, MAINTENANCE, LOG/ACCOUNT, ASSETS REGISTRATION)
    if (currentRoute == '/home' ||
        currentRoute == '/maintenance' ||
        currentRoute == '/maintenance-tasks' ||
        currentRoute == '/maintenance-schedule' ||
        currentRoute == '/account' ||
        currentRoute == '/assets-registration') {
      return Assets.icons.qr;
    }
    // Show Search icon for other routes
    return Assets.icons.search;
  }

  /// Handle center button tap
  void _handleCenterButtonTap(BuildContext context) {
    // For assets registration route, always go to QR scan
    if (currentRoute == '/assets-registration') {
      context.go('/qr-scan');
      return;
    }
    
    // Check if we should show search modal
    if (_getCenterButtonIcon() == Assets.icons.search) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SearchModal(
            onSearch: (searchQuery) {
              // Handle search logic here
              // You can implement search functionality based on current route
            },
            onCancel: () {
              // Dialog will close automatically
            },
          );
        },
      );
      return;
    }
    
    // For QR icon, navigate to QR scan
    context.go('/qr-scan');
  }
}
