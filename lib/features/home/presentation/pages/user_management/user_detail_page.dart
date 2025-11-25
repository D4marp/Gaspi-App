import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/gen/assets.gen.dart';
import '../../../../auth/presentation/providers/auth_provider.dart';
import '../../widgets/role_based_bottom_navigation.dart';

class UserDetailPage extends ConsumerWidget {
  final String userName;

  const UserDetailPage({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final userRole = user?.role.value ?? 'production';
    final currentRoute = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final navHeight = screenHeight * 0.11;

    // Mock user data
    const mockUsers = {
      'Ramdan Hasyim': {
        'name': 'Ramdan Hasyim',
        'username': 'hasyim772',
        'email': 'r.hasyim@gmail.com',
        'role': 'Superadmin',
        'status': 'Active',
        'joinDate': '2024-01-15',
      },
      'Hilman': {
        'name': 'Hilman',
        'username': 'hilman123',
        'email': 'hilman@gmail.com',
        'role': 'Admin',
        'status': 'Active',
        'joinDate': '2024-06-20',
      },
      'Jubari': {
        'name': 'Jubari',
        'username': 'jubari456',
        'email': 'jubari@gmail.com',
        'role': 'Admin',
        'status': 'Active',
        'joinDate': '2024-07-10',
      },
      'Doni Tri': {
        'name': 'Doni Tri',
        'username': 'donitri789',
        'email': 'donitri@gmail.com',
        'role': 'Maintenance',
        'status': 'Active',
        'joinDate': '2024-08-05',
      },
      'Akbar Faizal Dokoni': {
        'name': 'Akbar Faizal Dokoni',
        'username': 'akbarfaizal',
        'email': 'akbar.faizal@gmail.com',
        'role': 'Maintenance',
        'status': 'Active',
        'joinDate': '2024-09-12',
      },
    };

    // Decode userName dari URL parameter
    final decodedUserName = Uri.decodeComponent(userName);
    final userDetail = mockUsers[decodedUserName] ?? mockUsers['Ramdan Hasyim']!;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          // Main Content - Scrollable
          Positioned(
            left: screenWidth * 0.08,
            top: screenHeight * 0.14,
            right: screenWidth * 0.08,
            bottom: navHeight + (screenHeight * 0.02),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Title with Edit Icon
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF007EFF),
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 10,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            userDetail['name'] as String,
                            style: const TextStyle(
                              color: Color(0xFF101828),
                              fontSize: 16,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w700,
                              height: 1.20,
                              letterSpacing: -0.32,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            final encodedName = Uri.encodeComponent(userDetail['name'] as String);
                            context.push('/user-management/edit/$encodedName');
                          },
                          child: SvgPicture.asset(
                            Assets.icons.edit,
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // User Details
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: screenHeight * 0.03),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight * 0.01),
                        // Username
                        _buildDetailRow(
                          'Username',
                          userDetail['username'] as String,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // Email
                        _buildDetailRow(
                          'Email',
                          userDetail['email'] as String,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // Role
                        _buildDetailRow(
                          'Role',
                          userDetail['role'] as String,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // Status
                        _buildDetailRow(
                          'Status',
                          userDetail['status'] as String,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // Join Date
                        _buildDetailRow(
                          'Join Date',
                          userDetail['joinDate'] as String,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.025),
                        // Divider
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: const Color(0xFFEDEDED),
                        ),
                      ],
                    ),
                  ),

                  // User Description
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 16,
                      children: [
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          'Account Information',
                          style: TextStyle(
                            color: const Color(0xFF353535),
                            fontSize: 20,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w700,
                            height: 1.20,
                            letterSpacing: -0.40,
                          ),
                        ),
                        Text(
                          'User account details and permissions managed by GWN Administrator',
                          style: TextStyle(
                            color: const Color(0xFF677487),
                            fontSize: 14,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w400,
                            height: 1.40,
                            letterSpacing: -0.28,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Header Section - Fixed
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: screenHeight * 0.06,
                left: screenWidth * 0.08,
                right: screenWidth * 0.08,
                bottom: screenHeight * 0.015,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            size: 20,
                            color: Color(0xFF393D4E),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'User Administrator Detail',
                          style: TextStyle(
                            color: const Color(0xFF191D0B),
                            fontSize: 16,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w700,
                            height: 1.10,
                            letterSpacing: -0.32,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Floating Edit Button
          Positioned(
            left: screenWidth * 0.5 - (screenHeight * 0.066) / 2,
            top: screenHeight * 0.84,
            child: Container(
              width: screenHeight * 0.066,
              height: screenHeight * 0.066,
              padding: EdgeInsets.all(screenHeight * 0.016),
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
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: () {
                  final encodedName = Uri.encodeComponent(userName);
                  context.push('/user-management/edit/$encodedName');
                },
                child: Icon(
                  Icons.edit_outlined,
                  size: screenWidth * 0.05,
                  color: Colors.white,
                ),
              ),
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

  Widget _buildDetailRow(String label, String value, double screenWidth) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: screenWidth * 0.23,
            child: Text(
              label,
              style: TextStyle(
                color: const Color(0xFF677487),
                fontSize: 14,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w600,
                height: 1.40,
                letterSpacing: -0.28,
              ),
            ),
          ),
          Text(
            ':',
            style: TextStyle(
              color: const Color(0xFF677487),
              fontSize: 14,
              fontFamily: 'Nunito Sans',
              fontWeight: FontWeight.w600,
              height: 1.40,
              letterSpacing: -0.28,
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: const Color(0xFF677487),
                fontSize: 14,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w600,
                height: 1.40,
                letterSpacing: -0.28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
