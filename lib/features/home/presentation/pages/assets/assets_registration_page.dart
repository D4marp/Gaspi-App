import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../auth/presentation/providers/auth_provider.dart';
import '../../widgets/role_based_bottom_navigation.dart';

class AssetsRegistrationPage extends ConsumerStatefulWidget {
  const AssetsRegistrationPage({super.key});

  @override
  ConsumerState<AssetsRegistrationPage> createState() =>
      _AssetsRegistrationPageState();
}

class _AssetsRegistrationPageState extends ConsumerState<AssetsRegistrationPage> {
  late TextEditingController _searchController;

  // Mock data for registered cylinders
  final List<Map<String, String>> _assets = [
    {
      'id': '251234',
      'product': 'Oxygen (O2) @47L',
      'type': 'Oxygen (O2)',
      'member': 'PT. CATERPILLAR',
    },
    {
      'id': '251233',
      'product': 'Oxygen (O2) @47L',
      'type': 'Oxygen (O2)',
      'member': 'PT. CATERPILLAR',
    },
    {
      'id': '251232',
      'product': 'Nitrogen (N2) @50L',
      'type': 'Nitrogen (N2)',
      'member': 'PT. GOLDSTAR',
    },
    {
      'id': '251231',
      'product': 'Argon (Ar) @40L',
      'type': 'Argon (Ar)',
      'member': 'PT. SEMEN INDONESIA',
    },
    {
      'id': '251230',
      'product': 'Oxygen (O2) @47L',
      'type': 'Oxygen (O2)',
      'member': 'PT. CATERPILLAR',
    },
    {
      'id': '251229',
      'product': 'Nitrogen (N2) @50L',
      'type': 'Nitrogen (N2)',
      'member': 'PT. GOLDSTAR',
    },
    {
      'id': '251228',
      'product': 'Oxygen (O2) @47L',
      'type': 'Oxygen (O2)',
      'member': 'PT. CATERPILLAR',
    },
    {
      'id': '251227',
      'product': 'Argon (Ar) @40L',
      'type': 'Argon (Ar)',
      'member': 'PT. SEMEN INDONESIA',
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
                  // Title Row
                  SizedBox(
                    width: double.infinity,
                    height: 38,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Check if we can pop, otherwise go to home
                            if (Navigator.of(context).canPop()) {
                              context.pop();
                            } else {
                              context.go('/home');
                            }
                          },
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 20,
                              color: Color(0xFF101828),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Registered Assets',
                            style: TextStyle(
                              color: Color(0xFF101828),
                              fontSize: 20,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w700,
                              height: 1.20,
                              letterSpacing: -0.60,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Search and Filter Row
                  SizedBox(
                    height: 38,
                    child: Row(
                      children: [
                        // Search Bar
                        Expanded(
                          child: Container(
                            height: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.036,
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
                              children: [
                                const Icon(
                                  Icons.search,
                                  size: 18,
                                  color: Color(0xFF9C9C9C),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                Expanded(
                                  child: TextField(
                                    controller: _searchController,
                                    cursorColor: const Color(0xFF007EFF),
                                    style: TextStyle(
                                      color: const Color(0xFF101828),
                                      fontSize: screenWidth * 0.032,
                                      fontFamily: 'Nunito Sans',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    decoration: const InputDecoration(
                                      hintText: 'Search at Cylinder',
                                      hintStyle: TextStyle(
                                        color: Color(0xFF9C9C9C),
                                        fontSize: 12,
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
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.031),
                        // Filter Button
                        GestureDetector(
                          onTap: () {
                            // TODO: Open filter modal
                          },
                          child: Container(
                            width: 38,
                            height: 38,
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
                            child: const Icon(
                              Icons.tune,
                              size: 20,
                              color: Color(0xFF101828),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Sort and Filter Chips - Scrollable
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // Latest Chip
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.062,
                            vertical: screenHeight * 0.008,
                          ),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF007EFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Latest',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.80),
                              fontSize: screenWidth * 0.032,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w600,
                              height: 1.40,
                              letterSpacing: -0.24,
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.031),
                        // Gas Type Filter
                        _buildFilterChip(screenWidth, 'Gas Type'),
                        SizedBox(width: screenWidth * 0.031),
                        // Capacity Filter
                        _buildFilterChip(screenWidth, 'Capacity'),
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
            top: screenHeight * 0.26,
            right: screenWidth * 0.082,
            bottom: 0,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.18),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Registered Cylinders Section
                    Text(
                      'Registered Cylinders',
                      style: TextStyle(
                        color: const Color(0xFF101828),
                        fontSize: screenWidth * 0.051,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w700,
                        height: 1.10,
                        letterSpacing: -0.40,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.024),
                    // Assets List
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      spacing: screenHeight * 0.012,
                      children: _assets
                          .map((asset) => _buildAssetCard(context, asset, screenWidth, screenHeight))
                          .toList(),
                    ),
                    SizedBox(height: screenHeight * 0.024),
                    // Pagination
                    _buildPagination(screenWidth, screenHeight),
                  ],
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

  Widget _buildFilterChip(double screenWidth, String label) {
    return GestureDetector(
      onTap: () {
        // TODO: Open filter modal
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.062,
          vertical: screenWidth * 0.02,
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
          children: [
            Text(
              label,
              style: TextStyle(
                color: const Color(0xCC777985),
                fontSize: screenWidth * 0.032,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w600,
                height: 1.40,
                letterSpacing: -0.24,
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            const Icon(
              Icons.expand_more,
              size: 12,
              color: Color(0xCC777985),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetCard(
    BuildContext context,
    Map<String, String> asset,
    double screenWidth,
    double screenHeight,
  ) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to asset detail
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          shadows: [
            BoxShadow(
              color: const Color(0x0A000000),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: ID and Product
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: screenHeight * 0.008,
                children: [
                  Text(
                    asset['id'] ?? '',
                    style: TextStyle(
                      color: const Color(0xFF353535),
                      fontSize: screenWidth * 0.036,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w600,
                      height: 1.40,
                      letterSpacing: -0.28,
                    ),
                  ),
                  Text(
                    asset['product'] ?? '',
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
            SizedBox(width: screenWidth * 0.031),
            // Right: Type and Member
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: screenHeight * 0.008,
                children: [
                  Text(
                    asset['type'] ?? '',
                    style: TextStyle(
                      color: const Color(0xFF007EFF),
                      fontSize: screenWidth * 0.036,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w600,
                      height: 1.40,
                      letterSpacing: -0.28,
                    ),
                  ),
                  Text(
                    asset['member'] ?? '',
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
          ],
        ),
      ),
    );
  }

  Widget _buildPagination(double screenWidth, double screenHeight) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Previous Button
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenWidth * 0.02,
            ),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1,
                  color: Color(0xFFD4DBEA),
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              shadows: [
                BoxShadow(
                  color: const Color(0x07090B0E),
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                )
              ],
            ),
            child: Text(
              'Previous',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF9C9C9C),
                fontSize: screenWidth * 0.032,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w400,
                height: 1.60,
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.031),
          // Page Numbers
          Row(
            spacing: screenWidth * 0.02,
            children: [
              _buildPageNumber(screenWidth, '1', isActive: true),
              _buildPageNumber(screenWidth, '2', isActive: false),
              _buildPageNumber(screenWidth, '...', isActive: false),
              _buildPageNumber(screenWidth, '8', isActive: false),
              _buildPageNumber(screenWidth, '9', isActive: false),
            ],
          ),
          SizedBox(width: screenWidth * 0.031),
          // Next Button
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenWidth * 0.02,
            ),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1,
                  color: Color(0xFFD4DBEA),
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              shadows: [
                BoxShadow(
                  color: const Color(0x07090B0E),
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                )
              ],
            ),
            child: Text(
              'Next',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF393D4E),
                fontSize: screenWidth * 0.032,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w400,
                height: 1.60,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageNumber(double screenWidth, String number, {required bool isActive}) {
    return Container(
      width: screenWidth * 0.085,
      height: screenWidth * 0.085,
      decoration: ShapeDecoration(
        color: isActive ? const Color(0xFF007EFF) : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        number,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isActive ? Colors.white : const Color(0xFF9C9C9C),
          fontSize: screenWidth * 0.032,
          fontFamily: 'Nunito Sans',
          fontWeight: FontWeight.w400,
          height: 1.60,
        ),
      ),
    );
  }
}
