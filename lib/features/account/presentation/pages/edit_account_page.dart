import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaspi_app/core/gen/assets.gen.dart';
import 'package:gaspi_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:gaspi_app/features/home/presentation/widgets/role_based_bottom_navigation.dart';
import 'package:go_router/go_router.dart';

class EditAccountPage extends ConsumerStatefulWidget {
  const EditAccountPage({super.key});

  @override
  ConsumerState<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends ConsumerState<EditAccountPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  double _sw(BuildContext c, double px) => px / 390 * MediaQuery.of(c).size.width;
  double _sh(BuildContext c, double px) => px / 844 * MediaQuery.of(c).size.height;

  @override
  void initState() {
    super.initState();
    // Load current user data
    final user = ref.read(currentUserProvider);
    if (user != null) {
      nameController.text = user.name;
      usernameController.text = user.name; // Using name as username since User model doesn't have username
      emailController.text = user.email;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool isRequired = true,
    bool obscureText = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: _sh(context, 12),
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '$label ',
                style: TextStyle(
                  color: const Color(0xFF353535),
                  fontSize: _sw(context, 14),
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w600,
                  height: 1.20,
                  letterSpacing: -0.28,
                ),
              ),
              if (isRequired)
                TextSpan(
                  text: '*',
                  style: TextStyle(
                    color: const Color(0xFFD04B22),
                    fontSize: _sw(context, 14),
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w600,
                    height: 1.20,
                    letterSpacing: -0.28,
                  ),
                ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: _sw(context, 24),
            vertical: _sh(context, 12),
          ),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: Color(0xFFF0F0F0),
              ),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            style: TextStyle(
              color: const Color(0xFF353535),
              fontSize: _sw(context, 12),
              fontFamily: 'Nunito Sans',
              fontWeight: FontWeight.w400,
              height: 1.40,
              letterSpacing: -0.24,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final userRole = user?.role.value ?? 'production';
    final currentRoute = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Header - Fixed at top
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: screenHeight * 0.06,
              left: screenWidth * 0.08,
              right: screenWidth * 0.08,
              bottom: screenHeight * 0.015,
            ),
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Icon(
                    Icons.arrow_back,
                    size: screenWidth * 0.06,
                    color: const Color(0xFF191D0B),
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                Text(
                  'Edit Account',
                  style: TextStyle(
                    color: const Color(0xFF191D0B),
                    fontSize: 16,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w700,
                    height: 1.10,
                    letterSpacing: -0.32,
                  ),
                ),
              ],
            ),
          ),

          // Main content - Scrollable and centered
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.08,
                vertical: screenHeight * 0.02,
              ),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 500),
                  padding: EdgeInsets.all(screenWidth * 0.06),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title
                      Text(
                        'My Information',
                        style: TextStyle(
                          color: const Color(0xFF101828),
                          fontSize: 20,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w700,
                          height: 1.20,
                          letterSpacing: -0.60,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),

                      // Profile photo section
                      Container(
                        padding: EdgeInsets.all(screenWidth * 0.06),
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
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            // Profile photo
                            Assets.logos.profile.image(
                              width: screenWidth * 0.22,
                              height: screenWidth * 0.22,
                              fit: BoxFit.cover,
                            ),
                            // Edit button with SVG icon - positioned at top right
                            Positioned(
                              right: -8,
                              top: -8,
                              child: Container(
                                padding: EdgeInsets.all(screenWidth * 0.02),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF353535),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x3F000000),
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: SvgPicture.asset(
                                  Assets.icons.edit2,
                                  width: screenWidth * 0.04,
                                  height: screenWidth * 0.04,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),

                      // Form fields
                      _buildTextField(
                        label: 'Name',
                        controller: nameController,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      
                      _buildTextField(
                        label: 'Username',
                        controller: usernameController,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      
                      _buildTextField(
                        label: 'Email',
                        controller: emailController,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      
                      _buildTextField(
                        label: 'Password',
                        controller: passwordController,
                        obscureText: true,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      
                      _buildTextField(
                        label: 'Confirm Password',
                        controller: confirmPasswordController,
                        obscureText: true,
                      ),
                      SizedBox(height: screenHeight * 0.04),

                      // Update button
                      GestureDetector(
                        onTap: () {
                          // Validate passwords match
                          if (passwordController.text != confirmPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Passwords do not match')),
                            );
                            return;
                          }

                          // TODO: Implement update profile
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Profile updated successfully')),
                          );
                          context.pop();
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: screenHeight * 0.015,
                          ),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF007EFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Update',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Bottom Navigation - Fixed at bottom
          RoleBasedBottomNavigation(
            currentRoute: currentRoute,
            userRole: userRole,
          ),
        ],
      ),
    );
  }
}
