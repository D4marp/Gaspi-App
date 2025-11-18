import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaspi_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/role_based_bottom_navigation.dart';

class MembersPage extends ConsumerStatefulWidget {
  const MembersPage({super.key});

  @override
  ConsumerState<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends ConsumerState<MembersPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final userRole = user?.role.value ?? 'admin';
    final currentRoute = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final navHeight = screenHeight * 0.11;

    // Mock data for members
    final members = [
      {'name': 'PT CATERPILLAR', 'location': 'Kota Batam'},
      {'name': 'PT. AMNOR SHIPYARD', 'location': 'Kota Batam'},
      {'name': 'PT. BANDAR ABADI', 'location': 'Kota Batam'},
      {'name': 'PT. KTU SHIPYARD', 'location': 'Kota Batam'},
      {'name': 'PT. MARVELL TAN', 'location': 'Kota Batam'},
      {'name': 'PT. PAX OCEAN', 'location': 'Kota Batam'},
      {'name': 'PT. WASCO', 'location': 'Kota Batam'},
      {'name': 'PT. SUMBER MARINE', 'location': 'Kota Batam'},
    ];

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
                top: screenHeight * 0.057,
                left: screenWidth * 0.082,
                right: screenWidth * 0.082,
                bottom: screenHeight * 0.014,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar & Notification
                  SizedBox(
                    width: double.infinity,
                    height: screenWidth * 0.097,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Search Bar
                        Expanded(
                          child: Container(
                            height: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.036,
                              vertical: screenHeight * 0.014,
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
                                  size: screenWidth * 0.046,
                                  color: const Color(0xFF9C9C9C),
                                ),
                                SizedBox(width: screenWidth * 0.021),
                                Expanded(
                                  child: TextField(
                                    controller: _searchController,
                                    cursorColor: const Color(0xFF007EFF),
                                    decoration: InputDecoration(
                                      hintText: 'Search at Member',
                                      hintStyle: TextStyle(
                                        color: const Color(0xFF9C9C9C),
                                        fontSize: screenWidth * 0.031,
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: -0.12,
                                      ),
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.zero,
                                    ),
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.031,
                                      fontFamily: 'Nunito Sans',
                                      color: const Color(0xFF101828),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.031),
                        
                        // Notification Button
                        GestureDetector(
                          onTap: () => context.push('/notification'),
                          child: Container(
                            width: screenWidth * 0.097,
                            height: screenWidth * 0.097,
                            padding: EdgeInsets.all(screenWidth * 0.026),
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  width: 0,
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(100),
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
                                // Red dot indicator
                                Positioned(
                                  left: screenWidth * 0.008,
                                  top: screenWidth * 0.008,
                                  child: Container(
                                    width: screenWidth * 0.013,
                                    height: screenWidth * 0.013,
                                    decoration: const ShapeDecoration(
                                      color: Color(0xFFE84848),
                                      shape: OvalBorder(
                                        side: BorderSide(
                                          width: 1,
                                          color: Color(0xFF68686D),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.notifications_none,
                                  size: screenWidth * 0.051,
                                  color: const Color(0xFF68686D),
                                ),
                              ],
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
            top: screenHeight * 0.13,
            right: screenWidth * 0.082,
            bottom: navHeight + (screenHeight * 0.02),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Page Title
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: screenHeight * 0.028),
                    child: Text(
                      'GWN Member List',
                      style: TextStyle(
                        color: const Color(0xFF101828),
                        fontSize: screenWidth * 0.051,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w700,
                        height: 1.10,
                        letterSpacing: -0.40,
                      ),
                    ),
                  ),

                  // Members List
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: members.map((member) {
                      return GestureDetector(
                        onTap: () => context.push('/member-detail'),
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: screenHeight * 0.014),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Member Name
                              Text(
                                member['name']!,
                                style: TextStyle(
                                  color: const Color(0xFF353535),
                                  fontSize: screenWidth * 0.036,
                                  fontFamily: 'Nunito Sans',
                                  fontWeight: FontWeight.w600,
                                  height: 1.40,
                                  letterSpacing: -0.28,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.009),
                            // Location
                            Text(
                              member['location']!,
                              style: TextStyle(
                                color: const Color(0xFF677487),
                                fontSize: screenWidth * 0.036,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w400,
                                height: 1.40,
                                letterSpacing: -0.28,
                              ),
                            ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),
          ),

          // Floating Add Button
          Positioned(
            bottom: navHeight + (screenHeight * 0.02),
            right: screenWidth * 0.082,
            child: GestureDetector(
              onTap: () {
                context.push('/add-member');
              },
              child: Container(
                padding: EdgeInsets.all(screenWidth * 0.031),
                decoration: ShapeDecoration(
                  color: const Color(0xFF5CBA4B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x26000000),
                      blurRadius: 6.80,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Icon(
                  Icons.add,
                  size: screenWidth * 0.082,
                  color: Colors.white,
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
}
