import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaspi_app/core/gen/assets.gen.dart';
import 'package:gaspi_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:gaspi_app/features/home/presentation/widgets/role_based_bottom_navigation.dart';
import 'package:gaspi_app/features/home/presentation/widgets/category_modal.dart';
import 'package:gaspi_app/features/home/presentation/widgets/package_modal.dart';
import 'package:go_router/go_router.dart';
import 'product_detail_page.dart';
import 'add_product_page.dart';
import 'package:gaspi_app/features/home/presentation/pages/notification/notification_page.dart';

class ProductsPage extends ConsumerWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final userRole = user?.role.value ?? 'production';
    final currentRoute = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final navHeight = screenHeight * 0.11;

    final products = [
      {
        'name': 'Oxygen Cylinder 40L 6,4 m3',
        'category': 'Oxygen',
      },
      {
        'name': 'Carbon Dioxide Cylinder 40L 25Kg',
        'category': 'Carbon Dioxide',
      },
      {
        'name': 'Carbon Dioxide Cylinder 50L 38,5Kg',
        'category': 'ArgonCarbon Dioxide',
      },
      {
        'name': 'Carbon Dioxide Cylinder 47L 30Kg',
        'category': 'Mix GasCarbon Dioxide',
      },
      {
        'name': 'Oxygen Transport Rack 12 Cylinder 40L 6,4 m3',
        'category': 'Oxygen',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          // Main Content Area with Products List
          Positioned(
            left: screenWidth * 0.08,
            top: screenHeight * 0.21,
            right: screenWidth * 0.08,
            bottom: navHeight + (screenHeight * 0.02),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Inventory List',
                    style: TextStyle(
                      color: const Color(0xFF101828),
                      fontSize: screenWidth * 0.052,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w700,
                      height: 1.10,
                      letterSpacing: -0.40,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      products.length,
                      (index) {
                        final product = products[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailPage(
                                  productName: product['name']!,
                                  productCategory: product['category']!,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product['name']!,
                                style: TextStyle(
                                  color: const Color(0xFF353535),
                                  fontSize: 14,
                                  fontFamily: 'Nunito Sans',
                                  fontWeight: FontWeight.w600,
                                  height: 1.40,
                                  letterSpacing: -0.28,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.008),
                              Text(
                                product['category']!,
                                style: TextStyle(
                                  color: const Color(0xFF677487),
                                  fontSize: 14,
                                  fontFamily: 'Nunito Sans',
                                  fontWeight: FontWeight.w400,
                                  height: 1.40,
                                  letterSpacing: -0.28,
                                ),
                              ),
                              if (index < products.length - 1)
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.015,
                                  ),
                                  child: Container(
                                    width: double.infinity,
                                    height: 1,
                                    color: const Color(0xFFF0F0F0),
                                ),
                              )
                              else
                                SizedBox(height: screenHeight * 0.015),
                            ],
                          ),
                        );
                      },
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
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.015),
                  // Search and Notification
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: screenHeight * 0.045,
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04,
                            vertical: screenHeight * 0.012,
                          ),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 1,
                                color: Color(0xFFF0F0F0),
                              ),
                              borderRadius: BorderRadius.circular(64),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search,
                                size: screenWidth * 0.045,
                                color: const Color(0xFF9C9C9C),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Expanded(
                                child: Text(
                                  'Search at Inventory',
                                  style: TextStyle(
                                    color: const Color(0xFF9C9C9C),
                                    fontSize: 12,
                                    fontFamily: 'Nunito Sans',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotificationPage(),
                            ),
                          );
                        },
                        child: Container(
                          width: screenHeight * 0.045,
                          height: screenHeight * 0.045,
                          padding: EdgeInsets.all(screenWidth * 0.025),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 1,
                                color: Color(0xFFEDEDED),
                              ),
                              borderRadius: BorderRadius.circular(300),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Icon(
                                Icons.notifications_none,
                                size: screenWidth * 0.05,
                                color: const Color(0xFF393D4E),
                              ),
                              Positioned(
                                right: screenWidth * 0.01,
                                top: screenHeight * 0.005,
                                child: Container(
                                  width: screenWidth * 0.025,
                                  height: screenWidth * 0.025,
                                  decoration: const ShapeDecoration(
                                    color: Color(0xFFE84848),
                                    shape: OvalBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Filter Pills
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Latest Button (Active)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.06,
                            vertical: screenHeight * 0.008,
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
                                'Latest',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.80),
                                  fontSize: 12,
                                  fontFamily: 'Nunito Sans',
                                  fontWeight: FontWeight.w600,
                                  height: 1.40,
                                  letterSpacing: -0.24,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        // Product Category Button
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
                            padding: EdgeInsets.only(
                              top: screenHeight * 0.008,
                              left: screenWidth * 0.06,
                              right: screenWidth * 0.04,
                              bottom: screenHeight * 0.008,
                            ),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  width: 1,
                                  color: Color(0xFFDCDBDB),
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Product Category',
                                  style: TextStyle(
                                    color: const Color(0xCC777985),
                                    fontSize: 12,
                                    fontFamily: 'Nunito Sans',
                                    fontWeight: FontWeight.w600,
                                    height: 1.40,
                                    letterSpacing: -0.24,
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Icon(
                                  Icons.expand_more,
                                  size: screenWidth * 0.03,
                                  color: const Color(0xCC777985),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        // Package Button
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
                            padding: EdgeInsets.only(
                              top: screenHeight * 0.008,
                              left: screenWidth * 0.06,
                              right: screenWidth * 0.04,
                              bottom: screenHeight * 0.008,
                            ),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  width: 1,
                                  color: Color(0xFFDCDBDB),
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Package',
                                  style: TextStyle(
                                    color: const Color(0xCC777985),
                                    fontSize: 12,
                                    fontFamily: 'Nunito Sans',
                                    fontWeight: FontWeight.w600,
                                    height: 1.40,
                                    letterSpacing: -0.24,
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Icon(
                                  Icons.expand_more,
                                  size: screenWidth * 0.03,
                                  color: const Color(0xCC777985),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                ],
              ),
            ),
          ),

            // Floating Add Button (bigger)
            Positioned(
            bottom: navHeight + (screenHeight * 0.02),
            right: screenWidth * 0.08,
            child: GestureDetector(
              onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => const AddProductPage(),
                ),
              );
              },
              
              child: SvgPicture.asset(
                Assets.icons.add,
                width: screenHeight * 0.08,
                height: screenHeight * 0.08,
              ),
              ),
            ),
            
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
