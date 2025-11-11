import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../auth/presentation/providers/auth_provider.dart';
import '../../widgets/role_based_bottom_navigation.dart';
import '../../widgets/category_modal.dart';
import '../../widgets/package_modal.dart';

class EditProductPage extends ConsumerStatefulWidget {
  final String productName;
  final String productCategory;

  const EditProductPage({
    super.key,
    required this.productName,
    required this.productCategory,
  });

  @override
  ConsumerState<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends ConsumerState<EditProductPage> {
  String? selectedCategory;
  String? selectedPackage;
  String? selectedWaterCapacity;
  String? selectedGasCapacity;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.productCategory;
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final userRole = user?.role.value ?? 'production';
    final currentRoute = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
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
                left: screenWidth * 0.082,
                right: screenWidth * 0.082,
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
                  SizedBox(
                    width: double.infinity,
                    height: 38,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
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
                              size: 24,
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
                  ),
                ],
              ),
            ),
          ),

          // Main Content - Scrollable
          Positioned(
            left: screenWidth * 0.082,
            top: screenHeight * 0.14,
            right: screenWidth * 0.082,
            bottom: 0,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.25),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
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
                    children: [
                      // Product Title
                      Text(
                        widget.productName,
                        style: const TextStyle(
                          color: Color(0xFF101828),
                          fontSize: 20,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w700,
                          height: 1.20,
                          letterSpacing: -0.60,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Form Fields
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Code Field
                            _buildFormField(
                              'Product Code/SKU',
                              'Enter Product Code/SKU',
                            ),
                            const SizedBox(height: 24),

                            // Category Field
                            _buildDropdownField(
                              'Gas Type/Category',
                              selectedCategory ?? 'Select Category',
                              onTap: () async {
                                final result = await showModalBottomSheet<String>(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => const CategoryModal(),
                                );
                                if (result != null) {
                                  setState(() {
                                    selectedCategory = result;
                                  });
                                }
                              },
                            ),
                            const SizedBox(height: 24),

                            // Package Field
                            _buildDropdownField(
                              'Package',
                              selectedPackage ?? 'Select Package',
                              onTap: () async {
                                final result = await showModalBottomSheet<String>(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => const PackageModal(),
                                );
                                if (result != null) {
                                  setState(() {
                                    selectedPackage = result;
                                  });
                                }
                              },
                            ),
                            const SizedBox(height: 24),

                            // Water Capacity Field
                            _buildDropdownField(
                              'Water Capacity',
                              selectedWaterCapacity ?? 'Select Water Capacity',
                              onTap: () {
                                // TODO: Open water capacity modal
                              },
                            ),
                            const SizedBox(height: 24),

                            // Gas Capacity Field
                            _buildDropdownField(
                              'Gas Capacity',
                              selectedGasCapacity ?? 'Select Gas Capacity',
                              onTap: () {
                                // TODO: Open gas capacity modal
                              },
                            ),
                            const SizedBox(height: 24),

                            // Description Field
                            _buildTextAreaField(
                              'Description',
                              'Enter description',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Update Button
                      GestureDetector(
                        onTap: () {
                          // TODO: Handle update product
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF007EFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Update Inventory Data',
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
  ) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
          const SizedBox(height: 12),
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
              shadows: const [
                BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 71,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: TextField(
              style: const TextStyle(
                color: Color(0xFF353535),
                fontSize: 12,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: const TextStyle(
                  color: Color(0xFF9C9C9C),
                  fontSize: 12,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.12,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(
    String label,
    String placeholder, {
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$label ',
                  style: const TextStyle(
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
          const SizedBox(height: 12),
          GestureDetector(
            onTap: onTap,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      placeholder,
                      style: const TextStyle(
                        color: Color(0xFF68686D),
                        fontSize: 12,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w400,
                        height: 1.40,
                        letterSpacing: -0.24,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.expand_more,
                    size: 14,
                    color: Color(0xFF68686D),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextAreaField(
    String label,
    String placeholder,
  ) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$label ',
                  style: const TextStyle(
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
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: 112,
            padding: const EdgeInsets.only(
              top: 12,
              left: 24,
              right: 24,
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
            child: TextField(
              maxLines: null,
              style: const TextStyle(
                color: Color(0xFF353535),
                fontSize: 12,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: const TextStyle(
                  color: Color(0xFF9C9C9C),
                  fontSize: 12,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.12,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
