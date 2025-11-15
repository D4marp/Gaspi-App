
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../auth/presentation/providers/auth_provider.dart';
import '../../widgets/role_based_bottom_navigation.dart';
import '../../widgets/category_modal.dart';
import '../../widgets/package_modal.dart';

class AddProductPage extends ConsumerStatefulWidget {
  const AddProductPage({super.key});

  @override
  ConsumerState<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends ConsumerState<AddProductPage> {
  String? selectedCategory;
  String? selectedSize;
  String? selectedPackage;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final userRole = user?.role.value ?? 'production';
    final currentRoute = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
                            'Add Inventory',
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
                    color: const Color(0xFFF5F5F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Add New Inventory',
                        style: TextStyle(
                          color: Color(0xFF101828),
                          fontSize: 20,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w700,
                          height: 1.20,
                          letterSpacing: -0.60,
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Product Code Field
                      _buildModernFormField(
                        'Product Code/SKU',
                        'Enter Product Code/SKU',
                      ),
                      const SizedBox(height: 24),
                      // Category Field
                      _buildModernDropdownField(
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
                      // Size Field
                      _buildModernDropdownField(
                        'Size',
                        selectedSize ?? 'Select Gas Capacity',
                        onTap: () {
                          // TODO: Open size modal
                        },
                      ),
                      const SizedBox(height: 24),
                      // Package Field
                      _buildModernDropdownField(
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
                      // Description Field
                      _buildModernTextAreaField(
                        'Description',
                        'Enter Product Description',
                      ),
                      const SizedBox(height: 32),
                      // Save Button
                      GestureDetector(
                        onTap: () {
                          // TODO: Save product
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

  // Modern single rounded container with subtle border and shadow.
  // Avoid nested rounded shapes: container has rounded corners, TextField has no border.
  Widget _buildModernFormField(
    String label,
    String placeholder,
  ) {
    return Column(
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
                  fontWeight: FontWeight.w600,
                  height: 1.40,
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
                  height: 1.40,
                  letterSpacing: -0.28,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          // Single rounded box
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFE6E6E9), width: 1),
            boxShadow: [
              // subtle elevation, keeps it modern but not layered rounded
              BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2)),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: TextField(
            cursorColor: const Color(0xFF007EFF),
            style: const TextStyle(
              color: Color(0xFF101828),
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
              border: InputBorder.none, // no inner border to avoid nested rounding
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }

  // Modern dropdown-styled row inside a single rounded container (no inner rounded).
  Widget _buildModernDropdownField(
    String label,
    String placeholder, {
    required VoidCallback onTap,
  }) {
    return Column(
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
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFE6E6E9), width: 1),
              boxShadow: [
                BoxShadow(color: Color(0x05000000), blurRadius: 6, offset: Offset(0, 2)),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    placeholder,
                    style: TextStyle(
                      color: placeholder.startsWith('Select') ? Color(0xFF9C9C9C) : Color(0xFF101828),
                      fontSize: 14,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const Icon(
                  Icons.expand_more,
                  size: 20,
                  color: Color(0xFF68686D),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Modern textarea using the same single rounded container approach.
  Widget _buildModernTextAreaField(
    String label,
    String placeholder,
  ) {
    return Column(
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
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFE6E6E9), width: 1),
            boxShadow: [
              BoxShadow(color: Color(0x05000000), blurRadius: 6, offset: Offset(0, 2)),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: TextField(
            maxLines: 5,
            cursorColor: const Color(0xFF007EFF),
            style: const TextStyle(
              color: Color(0xFF101828),
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
              border: InputBorder.none, // no inner border
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
}