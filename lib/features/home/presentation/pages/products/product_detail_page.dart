import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/gen/assets.gen.dart';
import '../../../../auth/presentation/providers/auth_provider.dart';
import '../../widgets/role_based_bottom_navigation.dart';
import 'edit_product_page.dart';

class ProductDetailPage extends ConsumerWidget {
  final String productName;
  final String productCategory;

  const ProductDetailPage({
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

    // Mock product details - bisa di-replace dengan data dari API
    final productDetails = {
      'prodCode': 'AG10L',
      'category': productCategory,
      'package': 'Cylinder',
      'waterCapacity': '40 Litres',
      'gasCapacity': '25 Kg',
      'description': '-',
    };

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
                  // Product Title
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                    child: Text(
                      productName,
                      style: TextStyle(
                        color: const Color(0xFF101828),
                        fontSize: 18,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w700,
                        height: 1.20,
                        letterSpacing: -0.36,
                      ),
                    ),
                  ),

                  // Product Specifications
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: screenHeight * 0.03),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight * 0.01),
                        // Prod Code
                        _buildDetailRow(
                          'Prod Code',
                          productDetails['prodCode']!,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // Category
                        _buildDetailRow(
                          'Category',
                          productDetails['category']!,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // Package
                        _buildDetailRow(
                          'Package',
                          productDetails['package']!,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // Water Capacity
                        _buildDetailRow(
                          'Water Capacity',
                          productDetails['waterCapacity']!,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // Gas Capacity
                        _buildDetailRow(
                          'Gas Capacity',
                          productDetails['gasCapacity']!,
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

                  // Item Description
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
                          'Item Description',
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
                          productDetails['description']!,
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
                      Expanded(
                        child: Text(
                          'Inventory Detail',
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

          // Edit Button - Fixed Position (Top Right)
          Positioned(
            right: screenWidth * 0.08,
            top: screenHeight * 0.063,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProductPage(
                      productName: productName,
                      productCategory: productCategory,
                    ),
                  ),
                );
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: SvgPicture.asset(
                  Assets.icons.edit,
                  width: 20,
                  height: 20,
                ),
              ),
            ),
          ),

          // Floating QR Button
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
              child: Icon(
                Icons.qr_code,
                size: screenWidth * 0.05,
                color: Colors.white,
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
