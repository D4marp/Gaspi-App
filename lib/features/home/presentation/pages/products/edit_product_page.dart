import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../auth/presentation/providers/auth_provider.dart';
import '../../widgets/role_based_bottom_navigation.dart';
import '../../widgets/category_modal.dart';
import '../../widgets/package_modal.dart';

class EditProductPage extends ConsumerWidget {
  final String productName;
  final String productCategory;

  const EditProductPage({
    super.key,
    required this.productName,
    required this.productCategory,
  });

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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card Container
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
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
                      spacing: 32,
                      children: [
                        // Product Title
                        Text(
                          productName,
                          style: const TextStyle(
                            color: Color(0xFF101828),
                            fontSize: 20,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w700,
                            height: 1.20,
                            letterSpacing: -0.60,
                          ),
                        ),

                        // Form Fields
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 24,
                          children: [
                            // Product Code Field
                            _buildFormField(
                              label: 'Product Code/SKU',
                              placeholder: 'Enter Product Code/SKU',
                              isRequired: true,
                            ),

                            // Category Field
                            _buildCategoryField(context, screenWidth),

                            // Package Field
                            _buildPackageField(context, screenWidth),

                            // Water Capacity Field
                            _buildFormField(
                              label: 'Water Capacity',
                              placeholder: 'Select Water Capacity',
                              isRequired: true,
                              isDropdown: true,
                            ),

                            // Gas Capacity Field
                            _buildFormField(
                              label: 'Gas Capacity',
                              placeholder: 'Select Gas Capacity',
                              isRequired: true,
                              isDropdown: true,
                            ),

                            // Description Field
                            _buildDescriptionField(),
                          ],
                        ),

                        // Update Button
                        GestureDetector(
                          onTap: () {
                            // TODO: Handle update product
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            decoration: ShapeDecoration(
                              color: const Color(0xFF007EFF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Update Inventory Data',
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
                        onTap: () => Navigator.pop(context),
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
                      const Expanded(
                        child: Text(
                          'Edit Inventory',
                          style: TextStyle(
                            color: Color(0xFF191D0B),
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

  Widget _buildFormField({
    required String label,
    required String placeholder,
    required bool isRequired,
    bool isDropdown = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '$label ',
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
                  text: '*',
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
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
            top: 10,
            left: 16,
            right: 24,
            bottom: 10,
          ),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1.50,
                color: Color(0xFFEDEDED),
              ),
              borderRadius: BorderRadius.circular(32),
            ),
            shadows: [
              BoxShadow(
                color: const Color(0x0A000000),
                blurRadius: 71,
                offset: const Offset(0, 0),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment:
                isDropdown ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                placeholder,
                style: const TextStyle(
                  color: Color(0xFF9C9C9C),
                  fontSize: 12,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.12,
                ),
              ),
              if (isDropdown)
                Container(
                  width: 14,
                  height: 14,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  child: const Icon(
                    Icons.expand_more,
                    size: 14,
                    color: Color(0xFF68686D),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryField(BuildContext context, double screenWidth) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: 'Gas Type/Category ',
                style: TextStyle(
                  color: Color(0xFF353535),
                  fontSize: 14,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w600,
                  height: 1.20,
                  letterSpacing: -0.28,
                ),
              ),
              const TextSpan(
                text: '*',
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
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              builder: (context) => const CategoryModal(),
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 10,
              left: 24,
              right: 16,
              bottom: 10,
            ),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1.50,
                  color: Color(0xFFEDEDED),
                ),
                borderRadius: BorderRadius.circular(32),
              ),
              shadows: [
                BoxShadow(
                  color: const Color(0x0A000000),
                  blurRadius: 71,
                  offset: const Offset(0, 0),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Select Category',
                  style: TextStyle(
                    color: Color(0xFF68686D),
                    fontSize: 12,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w400,
                    height: 1.40,
                    letterSpacing: -0.24,
                  ),
                ),
                Container(
                  width: 14,
                  height: 14,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  child: const Icon(
                    Icons.expand_more,
                    size: 14,
                    color: Color(0xFF68686D),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPackageField(BuildContext context, double screenWidth) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: 'Package ',
                style: TextStyle(
                  color: Color(0xFF353535),
                  fontSize: 14,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w600,
                  height: 1.20,
                  letterSpacing: -0.28,
                ),
              ),
              const TextSpan(
                text: '*',
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
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              builder: (context) => const PackageModal(),
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 10,
              left: 24,
              right: 16,
              bottom: 10,
            ),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1.50,
                  color: Color(0xFFEDEDED),
                ),
                borderRadius: BorderRadius.circular(32),
              ),
              shadows: [
                BoxShadow(
                  color: const Color(0x0A000000),
                  blurRadius: 71,
                  offset: const Offset(0, 0),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Select Package',
                  style: TextStyle(
                    color: Color(0xFF68686D),
                    fontSize: 12,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w400,
                    height: 1.40,
                    letterSpacing: -0.24,
                  ),
                ),
                Container(
                  width: 14,
                  height: 14,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  child: const Icon(
                    Icons.expand_more,
                    size: 14,
                    color: Color(0xFF68686D),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: 'Description ',
                style: TextStyle(
                  color: Color(0xFF353535),
                  fontSize: 14,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w600,
                  height: 1.20,
                  letterSpacing: -0.28,
                ),
              ),
              const TextSpan(
                text: '*',
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
        Container(
          width: double.infinity,
          height: 112,
          padding: const EdgeInsets.only(
            top: 12,
            left: 24,
            right: 110,
            bottom: 12,
          ),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: Color(0xFFF0F0F0),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const TextField(
            maxLines: null,
            decoration: InputDecoration(
              hintText: 'Enter description',
              hintStyle: TextStyle(
                color: Color(0xFF9C9C9C),
                fontSize: 12,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.12,
              ),
              border: InputBorder.none,
            ),
            style: TextStyle(
              color: Color(0xFF353535),
              fontSize: 12,
              fontFamily: 'Nunito Sans',
              fontWeight: FontWeight.w400,
              letterSpacing: -0.12,
            ),
          ),
        ),
      ],
    );
  }
}
