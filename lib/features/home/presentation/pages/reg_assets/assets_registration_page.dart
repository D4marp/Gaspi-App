import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../auth/presentation/providers/auth_provider.dart';
import '../../widgets/role_based_bottom_navigation.dart';
import '../../widgets/gas_type_bottom_sheet.dart';
import '../../widgets/capacity_bottom_sheet.dart';
import 'asset_detail_page.dart';

class AssetsRegistrationPage extends ConsumerStatefulWidget {
  const AssetsRegistrationPage({super.key});

  @override
  ConsumerState<AssetsRegistrationPage> createState() =>
      _AssetsRegistrationPageState();
}

class _AssetsRegistrationPageState extends ConsumerState<AssetsRegistrationPage> {
  late TextEditingController _searchController;
  String? _selectedGasType;
  String? _selectedCapacity;

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
                  // Sort and Filter Chips - Full Width
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Latest Chip
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.035,
                            vertical: screenHeight * 0.008,
                          ),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF007EFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Center(
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
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      // Gas Type Filter
                      Expanded(
                        flex: 1,
                        child: _buildFilterChip(screenWidth, screenHeight, 'Gas Type'),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      // Capacity Filter
                      Expanded(
                        flex: 1,
                        child: _buildFilterChip(screenWidth, screenHeight, 'Capacity'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Main Content - Scrollable
          Positioned(
            left: screenWidth * 0.082,
            top: screenHeight * 0.18,
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
                      children: _assets
                          .map((asset) => _buildAssetCard(context, asset, screenWidth, screenHeight))
                          .toList(),
                    ),
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

  Widget _buildFilterChip(double screenWidth, double screenHeight, String label) {
    return GestureDetector(
      onTap: () {
        if (label == 'Gas Type') {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => GasTypeBottomSheet(
              selectedGasType: _selectedGasType,
              onGasTypeSelected: (gasType) {
                setState(() {
                  _selectedGasType = gasType;
                });
              },
            ),
          );
        } else if (label == 'Capacity') {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => CapacityBottomSheet(
              selectedCapacity: _selectedCapacity,
              onCapacitySelected: (capacity) {
                setState(() {
                  _selectedCapacity = capacity;
                });
              },
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.035,
          vertical: screenHeight * 0.008,
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
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
              SizedBox(width: screenWidth * 0.015),
              const Icon(
                Icons.expand_more,
                size: 12,
                color: Color(0xCC777985),
              ),
            ],
          ),
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AssetDetailPage(assetId: asset['id']!),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: screenHeight * 0.015),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Column: ID and Product
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    asset['id'] ?? '',
                    style: const TextStyle(
                      color: Color(0xFF353535),
                      fontSize: 14,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w600,
                      height: 1.40,
                      letterSpacing: -0.28,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.008),
                  Text(
                    asset['product'] ?? '',
                    style: const TextStyle(
                      color: Color(0xFF677487),
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
            SizedBox(width: screenWidth * 0.02),
            // Right Column: Type and Member
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    asset['type'] ?? '',
                    style: const TextStyle(
                      color: Color(0xFF007EFF),
                      fontSize: 14,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w600,
                      height: 1.40,
                      letterSpacing: -0.28,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.008),
                  Text(
                    asset['member'] ?? '',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: Color(0xFF677487),
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
    );
  }
}
