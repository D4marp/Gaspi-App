import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../auth/presentation/providers/auth_provider.dart';
import '../../widgets/role_based_bottom_navigation.dart';

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

    // Mock asset data
    final asset = {
      'id': '251234',
      'cylinderNo': '251234',
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
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
                  Text(
                    'Cylinder Detail',
                    style: TextStyle(
                      color: const Color(0xFF191D0B),
                      fontSize: screenWidth * 0.041,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w700,
                      height: 1.10,
                      letterSpacing: -0.32,
                    ),
                  ),
                  SizedBox(width: 24),
                ],
              ),
            ),
          ),

          // Main Content - Scrollable
          Positioned(
            left: screenWidth * 0.082,
            top: screenHeight * 0.13,
            right: screenWidth * 0.082,
            bottom: 0,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.18),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      'Cylinder ${asset['cylinderNo']}',
                      style: TextStyle(
                        color: const Color(0xFF101828),
                        fontSize: screenWidth * 0.051,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w700,
                        height: 1.20,
                        letterSpacing: -0.60,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.024),

                    // Asset Information Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(screenWidth * 0.062),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color(0xFFEDEDED),
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: screenHeight * 0.024,
                        children: [
                          // Asset Information Section
                          _buildSection(
                            screenWidth,
                            screenHeight,
                            'Asset Information',
                            [
                              _buildDetailRow('Cylinder No.', asset['cylinderNo']!),
                              _buildDetailRow('Registered for', asset['registeredFor']!),
                              _buildDetailRow('Water Capacity', asset['waterCapacity']!),
                              _buildDetailRow('Manufacture', asset['manufacture']!),
                              _buildDetailRow('Working Pressure', asset['workingPressure']!),
                              _buildDetailRow('Testing Pressure', asset['testingPressure']!),
                              _buildDetailRow('Purchase Date', asset['purchaseDate']!),
                              _buildDetailRow('Testing Date', asset['testingDate']!),
                              _buildDetailRow('Tare Weight', asset['tareWeight']!),
                              _buildDetailRow('MFG Certificate', asset['mfgCertificate']!),
                              _buildDetailRow('Type', asset['type']!),
                              _buildDetailRow('Gas Capacity', asset['gasCapacity']!),
                            ],
                          ),

                          _buildDivider(),

                          // Owner Information Section
                          _buildSection(
                            screenWidth,
                            screenHeight,
                            'Owner Information',
                            [
                              _buildDetailRow('Owner', asset['owner']!),
                              _buildDetailRow('Name', asset['ownerName']!),
                            ],
                          ),

                          _buildDivider(),

                          // Remark Section
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: screenHeight * 0.016,
                            children: [
                              Text(
                                'Remark',
                                style: TextStyle(
                                  color: const Color(0xFF353535),
                                  fontSize: screenWidth * 0.041,
                                  fontFamily: 'Nunito Sans',
                                  fontWeight: FontWeight.w700,
                                  height: 1.20,
                                  letterSpacing: -0.32,
                                ),
                              ),
                              Text(
                                asset['remark']!,
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
                        ],
                      ),
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

  Widget _buildSection(
    double screenWidth,
    double screenHeight,
    String title,
    List<Widget> items,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: screenHeight * 0.008,
      children: [
        Text(
          title,
          style: TextStyle(
            color: const Color(0xFF353535),
            fontSize: screenWidth * 0.041,
            fontFamily: 'Nunito Sans',
            fontWeight: FontWeight.w700,
            height: 1.20,
            letterSpacing: -0.32,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          spacing: screenHeight * 0.008,
          children: items,
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Builder(
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: screenWidth * 0.02,
          children: [
            SizedBox(
              width: screenWidth * 0.23,
              child: Text(
                label,
                style: TextStyle(
                  color: const Color(0xFF677487),
                  fontSize: screenWidth * 0.036,
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
                fontSize: screenWidth * 0.036,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w600,
                height: 1.40,
                letterSpacing: -0.28,
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  color: const Color(0xFF677487),
                  fontSize: screenWidth * 0.036,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w600,
                  height: 1.40,
                  letterSpacing: -0.28,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDivider() {
    return Builder(
      builder: (context) {
        final screenHeight = MediaQuery.of(context).size.height;
        return Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.012),
          child: Container(
            width: double.infinity,
            height: 1,
            color: const Color(0xFFEDEDED),
          ),
        );
      },
    );
  }
}
