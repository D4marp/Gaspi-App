import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/gen/assets.gen.dart';
import '../../../../auth/presentation/providers/auth_provider.dart';
import '../../widgets/role_based_bottom_navigation.dart';
import 'edit_asset_page.dart';

class AssetDetailPage extends ConsumerWidget {
  final String assetId;

  const AssetDetailPage({
    super.key,
    required this.assetId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final userRole = user?.role.value ?? 'production';
    final currentRoute = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final navHeight = screenHeight * 0.11;

    // Mock asset data - sesuaikan dengan data dari props atau API
    final asset = {
      'id': assetId,
      'cylinderNo': assetId,
      'registeredFor': 'PT. Gaspi Cipta Nusantara',
      'waterCapacity': '40 Liters',
      'manufacture': 'IDS',
      'workingPressure': '150 Bar',
      'testingPressure': '250 Bar',
      'purchaseDate': '17-12-2022',
      'testingDate': '17-12-2022',
      'tareWeight': '30',
      'mfgCertificate': '1824621391',
      'type': 'Oxygen (O2)',
      'gasCapacity': '30 (Kg) Kilogram',
      'owner': 'Gaspi Own Property',
      'ownerName': 'Gaspi Waralaba Nusantara',
      'remark': 'Asset was registered in 17-12-2022 for PT. Amnor Shipyard.',
    };

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
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
                  // Cylinder Title with Icon and Edit Button
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Assets.icons.mdiGasCylinder,
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Cylinder #${asset['cylinderNo']}',
                            style: const TextStyle(
                              color: Color(0xFF101828),
                              fontSize: 16,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w700,
                              height: 1.20,
                              letterSpacing: -0.32,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditAssetPage(assetId: assetId),
                              ),
                            );
                          },
                          child: SvgPicture.asset(
                            Assets.icons.edit,
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Asset Specifications
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: screenHeight * 0.03),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight * 0.01),
                        // Cylinder No
                        _buildDetailRow(
                          'Cylinder No',
                          asset['cylinderNo']!,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // Registered For
                        _buildDetailRow(
                          'Registered For',
                          asset['registeredFor']!,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // Water Capacity
                        _buildDetailRow(
                          'Water Capacity',
                          asset['waterCapacity']!,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // Manufacture
                        _buildDetailRow(
                          'Manufacture',
                          asset['manufacture']!,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // Working Pressure
                        _buildDetailRow(
                          'Working Pressure',
                          asset['workingPressure']!,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // Testing Pressure
                        _buildDetailRow(
                          'Testing Pressure',
                          asset['testingPressure']!,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // Purchase Date
                        _buildDetailRow(
                          'Purchase Date',
                          asset['purchaseDate']!,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // Testing Date
                        _buildDetailRow(
                          'Testing Date',
                          asset['testingDate']!,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // Tare Weight
                        _buildDetailRow(
                          'Tare Weight',
                          asset['tareWeight']!,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // Mfg Certificate
                        _buildDetailRow(
                          'Mfg Certificate',
                          asset['mfgCertificate']!,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // Type
                        _buildDetailRow(
                          'Type',
                          asset['type']!,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // Gas Capacity
                        _buildDetailRow(
                          'Gas Capacity',
                          asset['gasCapacity']!,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // Owner
                        _buildDetailRow(
                          'Owner',
                          asset['owner']!,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // Owner Name
                        _buildDetailRow(
                          'Owner Name',
                          asset['ownerName']!,
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

                  // Remark Section
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight * 0.01),
                        const Text(
                          'Remark',
                          style: TextStyle(
                            color: Color(0xFF353535),
                            fontSize: 20,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w700,
                            height: 1.20,
                            letterSpacing: -0.40,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          asset['remark']!,
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
                      const Expanded(
                        child: Text(
                          'Cylinder Detail',
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
                ],
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
              decoration: const ShapeDecoration(
                color: Color(0xFF007EFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x59598CFF),
                    blurRadius: 22,
                    offset: Offset(0, 0),
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
            width: screenWidth * 0.35,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF677487),
                fontSize: 14,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w600,
                height: 1.40,
                letterSpacing: -0.28,
              ),
            ),
          ),
          const Text(
            ':',
            style: TextStyle(
              color: Color(0xFF677487),
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
              style: const TextStyle(
                color: Color(0xFF677487),
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
