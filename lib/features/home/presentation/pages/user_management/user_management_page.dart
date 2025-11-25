import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaspi_app/core/gen/assets.gen.dart';
import 'package:gaspi_app/features/home/presentation/widgets/role_based_bottom_navigation.dart';
import 'package:go_router/go_router.dart';

class UserManagementPage extends ConsumerStatefulWidget {
  const UserManagementPage({super.key});

  @override
  ConsumerState<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends ConsumerState<UserManagementPage> {
  final TextEditingController searchController = TextEditingController();
  String selectedFilter = 'Latest';

  // Mock user data
  final List<Map<String, String>> users = [
    {
      'name': 'Ramdan Hasyim',
      'role': 'Superadmin',
      'status': 'Active',
      'date': '2025-01-15',
    },
    {
      'name': 'Hilman',
      'role': 'Admin',
      'status': 'Active',
      'date': '2025-01-14',
    },
    {
      'name': 'Jubari',
      'role': 'Admin',
      'status': 'Active',
      'date': '2025-01-13',
    },
    {
      'name': 'Doni Tri',
      'role': 'Maintenance',
      'status': 'Active',
      'date': '2025-01-12',
    },
    {
      'name': 'Akbar Faizal Dokoni',
      'role': 'Maintenance',
      'status': 'Active',
      'date': '2025-01-11',
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final navHeight = screenHeight * 0.11;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          // Main Content Area with Users List
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
                    'GWN Administrator',
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
                      users.length,
                      (index) {
                        final user = users[index];
                        final name = user['name'] ?? '';
                        final role = user['role'] ?? '';

                        // Filter by search
                        if (searchController.text.isNotEmpty &&
                            !name
                                .toLowerCase()
                                .contains(searchController.text.toLowerCase())) {
                          return SizedBox.shrink();
                        }

                        return GestureDetector(
                          onTap: () {
                            // Using Uri.encodeComponent to handle spaces and special characters
                            final encodedName = Uri.encodeComponent(name);
                            context.push('/user-management/detail/$encodedName');
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
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
                                role,
                                style: TextStyle(
                                  color: const Color(0xFF677487),
                                  fontSize: 14,
                                  fontFamily: 'Nunito Sans',
                                  fontWeight: FontWeight.w400,
                                  height: 1.40,
                                  letterSpacing: -0.28,
                                ),
                              ),
                              if (index < users.length - 1)
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
                                width: 0,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(64),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x0A000000),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              ),
                            ],
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
                                child: TextField(
                                  controller: searchController,
                                  cursorColor: const Color(0xFF007EFF),
                                  style: TextStyle(
                                    color: const Color(0xFF101828),
                                    fontSize: 12,
                                    fontFamily: 'Nunito Sans',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: 'Search at GWN Administrator',
                                    hintStyle: TextStyle(
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
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  SizedBox(width: screenWidth * 0.03),
                      GestureDetector(
                        onTap: () {
                          context.push('/notification');
                        },
                        child: Container(
                          width: screenHeight * 0.045,
                          height: screenHeight * 0.045,
                          padding: EdgeInsets.all(screenWidth * 0.025),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 0,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(300),
                            ),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x0A000000),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              ),
                            ],
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
                        // Active Button
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedFilter = 'Active';
                            });
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
                                  'Active',
                                  style: TextStyle(
                                    color: const Color(0xCC777985),
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
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        // Inactive Button
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedFilter = 'Inactive';
                            });
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
                                  'Inactive',
                                  style: TextStyle(
                                    color: const Color(0xCC777985),
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
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                ],
              ),
            ),
          ),

          // Floating Add Button
            Positioned(
            bottom: navHeight + (screenHeight * 0.02),
            right: screenWidth * 0.08,
            child: GestureDetector(
              onTap: () {
                // Navigate to add user page
                context.push('/user-management/add');
              },
              child: SvgPicture.asset(
                Assets.icons.add,
                width: screenHeight * 0.08,
                height: screenHeight * 0.08,
              ),
            ),
          ),

          // Bottom Navigation
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: RoleBasedBottomNavigation(
              currentRoute: currentRoute,
              userRole: 'admin',
            ),
          ),
        ],
      ),
    );
  }
}
