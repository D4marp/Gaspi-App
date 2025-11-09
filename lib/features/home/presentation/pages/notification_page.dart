import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../widgets/role_based_bottom_navigation.dart';

class NotificationPage extends ConsumerWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final userRole = user?.role.value ?? 'production';
    final currentRoute = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final navHeight = screenHeight * 0.11;

    return Scaffold(
      // backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          // Main Content - Scrollable
          Positioned(
            left: 0,
            right: 0,
            top: screenHeight * 0.12,
            bottom: navHeight,
            child: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    final items = [
                      'Cylinder 251231',
                      'Manifold 251212',
                      'Cylinder 251216',
                      'Cylinder 251230',
                    ];
                    final item = items[index % items.length];

                    return _buildNotificationItem(
                      item,
                      '21/04/2025',
                      screenWidth,
                      screenHeight,
                    );
                  },
                ),
              ),
            ),
          ),

          // Header Section - Fixed
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                left: screenWidth * 0.08,
                right: screenWidth * 0.08,
                top: screenHeight * 0.06,
                bottom: screenHeight * 0.02,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        context.go('/home');
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.arrow_back,
                        color: const Color(0xFF191D0B),
                        size: screenWidth * 0.055,
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Text(
                    'Notification',
                    style: TextStyle(
                      color: const Color(0xFF191D0B),
                      fontSize: screenWidth * 0.04,
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

  Widget _buildNotificationItem(
    String itemName,
    String date,
    double screenWidth,
    double screenHeight,
  ) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.08,
            vertical: screenHeight * 0.02,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Blue dot indicator
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * 0.003,
                ),
                child: Container(
                  width: screenWidth * 0.013,
                  height: screenWidth * 0.013,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF007EFF),
                    shape: OvalBorder(),
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.03),
              // Content
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title with bold and regular text
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: itemName,
                            style: TextStyle(
                              color: const Color(0xFF393D4E),
                              fontSize: screenWidth * 0.035,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w600,
                              height: 1.40,
                            ),
                          ),
                          TextSpan(
                            text: ' requested to maintenance',
                            style: TextStyle(
                              color: const Color(0xFF393D4E),
                              fontSize: screenWidth * 0.035,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w400,
                              height: 1.40,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.008),
                    // Date
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: screenWidth * 0.03,
                          color: const Color(0xFF393D4E),
                        ),
                        SizedBox(width: screenWidth * 0.008),
                        Text(
                          date,
                          style: TextStyle(
                            color: const Color(0xFF393D4E),
                            fontSize: screenWidth * 0.03,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w600,
                            height: 1.20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Divider line dengan padding
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Container(
            height: 1,
            color: const Color(0xFFE8E8E8),
          ),
        ),
      ],
    );
  }
}
