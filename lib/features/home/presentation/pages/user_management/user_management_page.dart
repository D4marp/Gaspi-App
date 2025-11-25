import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final currentRoute = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          // Header
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
                    'GWN Administrator',
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
          ),

          // Content Area with Search and Filter
          Positioned(
            left: screenWidth * 0.08,
            top: screenHeight * 0.12,
            right: screenWidth * 0.08,
            bottom: screenHeight * 0.12,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  Container(
                    height: screenHeight * 0.045,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.01,
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
                            style: TextStyle(
                              color: const Color(0xFF353535),
                              fontSize: screenWidth * 0.03,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w400,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Search at GWN Administrator',
                              hintStyle: TextStyle(
                                color: const Color(0xFF9C9C9C),
                                fontSize: screenWidth * 0.03,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w400,
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
                  SizedBox(height: screenHeight * 0.02),

                  // Filter Pills
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: screenWidth * 0.03,
                      children: [
                        'Latest',
                        'Active',
                        'Inactive',
                        'All'
                      ]
                          .map((filter) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedFilter = filter;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.04,
                                    vertical: screenHeight * 0.01,
                                  ),
                                  decoration: ShapeDecoration(
                                    color: selectedFilter == filter
                                        ? const Color(0xFF007EFF)
                                        : Colors.white,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 1,
                                        color: selectedFilter == filter
                                            ? const Color(0xFF007EFF)
                                            : const Color(0xFFEDEDED),
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    filter,
                                    style: TextStyle(
                                      color: selectedFilter == filter
                                          ? Colors.white
                                          : const Color(0xFF677487),
                                      fontSize: screenWidth * 0.03,
                                      fontFamily: 'Nunito Sans',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // User List Title
                  Text(
                    'GWN Administrator',
                    style: TextStyle(
                      color: const Color(0xFF101828),
                      fontSize: screenWidth * 0.045,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w700,
                      height: 1.20,
                      letterSpacing: -0.60,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // User List Items
                  ...users.map((user) {
                    final name = user['name'] ?? '';
                    final role = user['role'] ?? '';
                    final date = user['date'] ?? '';

                    // Filter by search
                    if (searchController.text.isNotEmpty &&
                        !name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                      return SizedBox.shrink();
                    }

                    return GestureDetector(
                      onTap: () {
                        // Navigate to user detail page
                        context.push('/user-management/detail/$name');
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: screenHeight * 0.015),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04,
                          vertical: screenHeight * 0.02,
                        ),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  name,
                                  style: TextStyle(
                                    color: const Color(0xFF353535),
                                    fontSize: screenWidth * 0.035,
                                    fontFamily: 'Nunito Sans',
                                    fontWeight: FontWeight.w600,
                                    height: 1.40,
                                    letterSpacing: -0.28,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.03,
                                    vertical: screenHeight * 0.005,
                                  ),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFF0F0F0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    role,
                                    style: TextStyle(
                                      color: const Color(0xFF677487),
                                      fontSize: screenWidth * 0.025,
                                      fontFamily: 'Nunito Sans',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Text(
                              date,
                              style: TextStyle(
                                color: const Color(0xFF9C9C9C),
                                fontSize: screenWidth * 0.025,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
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
