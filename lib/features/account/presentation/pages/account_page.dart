import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaspi_app/core/gen/assets.gen.dart';
import 'package:gaspi_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:gaspi_app/features/home/presentation/widgets/role_based_bottom_navigation.dart';
import 'package:go_router/go_router.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  double _sw(BuildContext c, double px) => px / 390 * MediaQuery.of(c).size.width;
  double _sh(BuildContext c, double px) => px / 844 * MediaQuery.of(c).size.height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final userRole = user?.role.value ?? 'production';
    final currentRoute = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          // Main content
          Positioned(
            left: _sw(context, 32),
            top: _sh(context, 110),
            child: Container(
              width: _sw(context, 326),
              padding: EdgeInsets.all(_sw(context, 24)),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x0C000000),
                    blurRadius: 71,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: _sh(context, 32),
                children: [
                  // Title
                  Text(
                    'My Information',
                    style: TextStyle(
                      color: const Color(0xFF101828),
                      fontSize: _sw(context, 20),
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w700,
                      height: 1.20,
                      letterSpacing: -0.60,
                    ),
                  ),

                  // Profile card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(_sw(context, 12)),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFFEDEDED),
                        ),
                        borderRadius: BorderRadius.circular(12),
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
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: _sw(context, 24),
                      children: [
                        // Profile photo
                        Assets.logos.profile.image(
                          width: _sw(context, 64),
                          height: _sw(context, 64),
                          fit: BoxFit.cover,
                        ),

                        // User info
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: _sh(context, 12),
                          children: [
                            Text(
                              user?.name ?? 'Thurston Moore',
                              style: TextStyle(
                                color: const Color(0xFF292D32),
                                fontSize: _sw(context, 14),
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w600,
                                height: 1.20,
                              ),
                            ),
                            Text(
                              user?.role.displayName ?? 'Superadmin',
                              style: TextStyle(
                                color: const Color(0xFF393D4E),
                                fontSize: _sw(context, 12),
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w500,
                                height: 1.20,
                              ),
                            ),
                            Text(
                              user?.email ?? 'thurstonmoore@gmail.com',
                              style: TextStyle(
                                color: const Color(0xFF393D4E),
                                fontSize: _sw(context, 12),
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w400,
                                height: 1.20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // User details
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: _sh(context, 24),
                    children: [
                      // Name
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: _sh(context, 12),
                        children: [
                          Text(
                            'Name',
                            style: TextStyle(
                              color: const Color(0xFF68686D),
                              fontSize: _sw(context, 14),
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w400,
                              height: 1.40,
                              letterSpacing: -0.28,
                            ),
                          ),
                          Text(
                            user?.name ?? 'Thurston Moore',
                            style: TextStyle(
                              color: const Color(0xFF353535),
                              fontSize: _sw(context, 16),
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w600,
                              height: 1.20,
                            ),
                          ),
                        ],
                      ),

                      // Username
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: _sh(context, 12),
                        children: [
                          Text(
                            'Username',
                            style: TextStyle(
                              color: const Color(0xFF68686D),
                              fontSize: _sw(context, 14),
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w400,
                              height: 1.40,
                              letterSpacing: -0.28,
                            ),
                          ),
                          Text(
                            user?.name ?? 'thurstonmoore',
                            style: TextStyle(
                              color: const Color(0xFF353535),
                              fontSize: _sw(context, 16),
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w600,
                              height: 1.20,
                            ),
                          ),
                        ],
                      ),

                      // Email
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: _sh(context, 12),
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                              color: const Color(0xFF68686D),
                              fontSize: _sw(context, 14),
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w400,
                              height: 1.40,
                              letterSpacing: -0.28,
                            ),
                          ),
                          Text(
                            user?.email ?? 'thurstonmoore@gmail.com',
                            style: TextStyle(
                              color: const Color(0xFF353535),
                              fontSize: _sw(context, 16),
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w600,
                              height: 1.20,
                            ),
                          ),
                        ],
                      ),

                      // Role
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: _sh(context, 12),
                        children: [
                          Text(
                            'Role',
                            style: TextStyle(
                              color: const Color(0xFF68686D),
                              fontSize: _sw(context, 14),
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w400,
                              height: 1.40,
                              letterSpacing: -0.28,
                            ),
                          ),
                          Text(
                            user?.role.displayName ?? 'Superadmin',
                            style: TextStyle(
                              color: const Color(0xFF353535),
                              fontSize: _sw(context, 16),
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w600,
                              height: 1.20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Action buttons
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: _sh(context, 12),
                    children: [
                      // Edit Account button
                      GestureDetector(
                        onTap: () {
                          context.push('/account/edit');
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: _sw(context, 20),
                            vertical: _sh(context, 12),
                          ),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 1,
                                color: Color(0xFF007EFF),
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Edit Account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF007EFF),
                              fontSize: _sw(context, 16),
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                      // Logout button
                      GestureDetector(
                        onTap: () async {
                          final shouldLogout = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Logout'),
                              content: const Text('Are you sure you want to logout?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context, false),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('Logout'),
                                ),
                              ],
                            ),
                          );

                          if (shouldLogout == true && context.mounted) {
                            await ref.read(authProvider.notifier).logout();
                            if (context.mounted) {
                              context.go('/login');
                            }
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: _sw(context, 20),
                            vertical: _sh(context, 12),
                          ),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF007EFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Logout',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: _sw(context, 16),
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Top header
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                top: _sh(context, 48),
                left: _sw(context, 32),
                right: _sw(context, 32),
                bottom: _sh(context, 12),
              ),
              decoration: const BoxDecoration(color: Colors.white),
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
                    'Account',
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
          ),

          // Bottom navigation
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
