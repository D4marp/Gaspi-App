import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../auth/presentation/providers/auth_provider.dart';
import '../../widgets/role_based_bottom_navigation.dart';

class AddUserPage extends ConsumerStatefulWidget {
  const AddUserPage({super.key});

  @override
  ConsumerState<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends ConsumerState<AddUserPage> {
  String? selectedRole;
  String? selectedStatus;

  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final List<String> roles = ['Superadmin', 'Admin', 'Maintenance'];
  final List<String> statuses = ['Active', 'Inactive'];

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final userRole = user?.role.value ?? 'production';
    final currentRoute = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final navHeight = screenHeight * 0.11;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
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
                          'Add GWN Administrator',
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
                  Text(
                    'Add New Administrator',
                    style: TextStyle(
                      color: const Color(0xFF101828),
                      fontSize: screenWidth * 0.05,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w700,
                      height: 1.20,
                      letterSpacing: -0.60,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // User Information Section
                  _buildSectionTitle('User Information', screenWidth),
                  SizedBox(height: screenHeight * 0.02),
                  _buildFormField('Full Name', 'Enter Full Name', _nameController, screenWidth),
                  SizedBox(height: screenHeight * 0.02),
                  _buildFormField('Username', 'Enter Username', _usernameController, screenWidth),
                  SizedBox(height: screenHeight * 0.02),
                  _buildFormField('Email', 'Enter Email Address', _emailController, screenWidth),
                  SizedBox(height: screenHeight * 0.03),

                  // Security Section
                  _buildSectionTitle('Security', screenWidth),
                  SizedBox(height: screenHeight * 0.02),
                  _buildFormField('Password', 'Enter Password', _passwordController, screenWidth, obscureText: true),
                  SizedBox(height: screenHeight * 0.02),
                  _buildFormField('Confirm Password', 'Confirm Password', _confirmPasswordController, screenWidth, obscureText: true),
                  SizedBox(height: screenHeight * 0.03),

                  // Role & Status Section
                  _buildSectionTitle('Role & Status', screenWidth),
                  SizedBox(height: screenHeight * 0.02),
                  _buildDropdownField(
                    'Role',
                    selectedRole ?? 'Select Role',
                    items: roles,
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value;
                      });
                    },
                    screenWidth: screenWidth,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  _buildDropdownField(
                    'Status',
                    selectedStatus ?? 'Select Status',
                    items: statuses,
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value;
                      });
                    },
                    screenWidth: screenWidth,
                  ),
                  SizedBox(height: screenHeight * 0.04),

                  // Submit Button
                  Container(
                    width: double.infinity,
                    height: screenHeight * 0.055,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF007EFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          // TODO: Submit form and add user
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('User added successfully')),
                          );
                          context.pop();
                        },
                        child: Center(
                          child: Text(
                            'Add Administrator',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.32,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                ],
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

  Widget _buildSectionTitle(String title, double screenWidth) {
    return Text(
      title,
      style: TextStyle(
        color: const Color(0xFF353535),
        fontSize: 16,
        fontFamily: 'Nunito Sans',
        fontWeight: FontWeight.w700,
        height: 1.20,
        letterSpacing: -0.32,
      ),
    );
  }

  Widget _buildFormField(
    String label,
    String hint,
    TextEditingController controller,
    double screenWidth, {
    bool obscureText = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
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
        SizedBox(height: screenWidth * 0.02),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenWidth * 0.03,
          ),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: Color(0xFFEDEDED),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            cursorColor: const Color(0xFF007EFF),
            style: const TextStyle(
              color: Color(0xFF101828),
              fontSize: 14,
              fontFamily: 'Nunito Sans',
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(0xFF9C9C9C),
                fontSize: 14,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField(
    String label,
    String value, {
    required List<String> items,
    required Function(String?) onChanged,
    required double screenWidth,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
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
        SizedBox(height: screenWidth * 0.02),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenWidth * 0.01,
          ),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: Color(0xFFEDEDED),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: Container(),
            style: const TextStyle(
              color: Color(0xFF101828),
              fontSize: 14,
              fontFamily: 'Nunito Sans',
              fontWeight: FontWeight.w400,
            ),
            dropdownColor: Colors.white,
            items: [
              DropdownMenuItem(
                value: value,
                child: Text(value),
              ),
              ...items.map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ),
              ),
            ],
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
