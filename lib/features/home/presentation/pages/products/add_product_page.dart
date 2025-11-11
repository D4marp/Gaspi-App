import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../auth/presentation/providers/auth_provider.dart';
import '../../widgets/role_based_bottom_navigation.dart';

class AddProductPage extends ConsumerWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final userRole = user?.role.value ?? 'production';
    final currentRoute = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final navHeight = screenHeight * 0.11;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main Content - Scrollable
          Positioned(
            left: screenWidth * 0.08,
            top: screenHeight * 0.14,
            right: screenWidth * 0.08,
            bottom: navHeight + (screenHeight * 0.02),
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(screenHeight * 0.024),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  shadows: [
                    BoxShadow(
                      color: const Color(0x0C000000),
                      blurRadius: 71,
                      offset: const Offset(0, 0),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add New Inventory',
                      style: TextStyle(
                        color: const Color(0xFF101828),
                        fontSize: 20,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w700,
                        height: 1.20,
                        letterSpacing: -0.60,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.032),
                    // Product Code/SKU Field
                    _buildFormField(
                      'Product Code/SKU',
                      'Enter Product Code/SKU',
                      screenWidth,
                      screenHeight,
                      isRequired: true,
                    ),
                    SizedBox(height: screenHeight * 0.024),
                    // Category Field
                    _buildDropdownField(
                      'Gas Type/Category',
                      'Select Category',
                      screenWidth,
                      screenHeight,
                      isRequired: true,
                    ),
                    SizedBox(height: screenHeight * 0.024),
                    // Size Field
                    _buildDropdownField(
                      'Size',
                      'Select Gas Capacity',
                      screenWidth,
                      screenHeight,
                      isRequired: true,
                    ),
                    SizedBox(height: screenHeight * 0.024),
                    // Package Field
                    _buildDropdownField(
                      'Package',
                      'Select Package',
                      screenWidth,
                      screenHeight,
                      isRequired: true,
                    ),
                    SizedBox(height: screenHeight * 0.024),
                    // Description Field
                    _buildTextAreaField(
                      'Description',
                      'Enter Product Description',
                      screenWidth,
                      screenHeight,
                      isRequired: true,
                    ),
                    SizedBox(height: screenHeight * 0.032),
                    // Save Button
                    GestureDetector(
                      onTap: () {
                        // TODO: Save product
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.012,
                        ),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF007EFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Save Inventory Data',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
                bottom: screenHeight * 0.012,
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
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: screenHeight * 0.038,
                          height: screenHeight * 0.038,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            size: screenWidth * 0.05,
                            color: const Color(0xFF393D4E),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.04),
                      Expanded(
                        child: Text(
                          'Add Inventory',
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

  Widget _buildFormField(
    String label,
    String placeholder,
    double screenWidth,
    double screenHeight, {
    bool isRequired = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: label,
                style: const TextStyle(
                  color: Color(0xFF101828),
                  fontSize: 14,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w400,
                  height: 1.40,
                  letterSpacing: -0.28,
                ),
              ),
              if (isRequired)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Color(0xFFF1003C),
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
        SizedBox(height: screenHeight * 0.008),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.008,
          ),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: Color(0xFFEDEDED),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: TextField(
            style: const TextStyle(
              color: Color(0xFF353535),
              fontSize: 14,
              fontFamily: 'Nunito Sans',
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: placeholder,
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
    String placeholder,
    double screenWidth,
    double screenHeight, {
    bool isRequired = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: label,
                style: const TextStyle(
                  color: Color(0xFF353535),
                  fontSize: 14,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w600,
                  height: 1.20,
                  letterSpacing: -0.28,
                ),
              ),
              if (isRequired)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Color(0xFFD04B22),
                    fontSize: 14,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w600,
                    height: 1.20,
                    letterSpacing: -0.28,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.008),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.008,
          ),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: Color(0xFFEDEDED),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                placeholder,
                style: const TextStyle(
                  color: Color(0xFF68686D),
                  fontSize: 14,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Icon(
                Icons.expand_more,
                size: 16,
                color: Color(0xFF68686D),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextAreaField(
    String label,
    String placeholder,
    double screenWidth,
    double screenHeight, {
    bool isRequired = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: label,
                style: const TextStyle(
                  color: Color(0xFF353535),
                  fontSize: 14,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w600,
                  height: 1.20,
                  letterSpacing: -0.28,
                ),
              ),
              if (isRequired)
                const TextSpan(
                  text: ' *',
                  style: TextStyle(
                    color: Color(0xFFD04B22),
                    fontSize: 14,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w600,
                    height: 1.20,
                    letterSpacing: -0.28,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.008),
        Container(
          width: double.infinity,
          height: screenHeight * 0.08,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.008,
          ),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: Color(0xFFF0F0F0),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: TextField(
            maxLines: null,
            style: const TextStyle(
              color: Color(0xFF353535),
              fontSize: 14,
              fontFamily: 'Nunito Sans',
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: placeholder,
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
}
