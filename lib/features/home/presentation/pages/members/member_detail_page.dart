import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/gen/assets.gen.dart';
import '../../../../auth/presentation/providers/auth_provider.dart';
import '../../widgets/role_based_bottom_navigation.dart';

class MemberDetailPage extends ConsumerWidget {
  final String? memberId;

  const MemberDetailPage({
    super.key,
    this.memberId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final userRole = user?.role.value ?? 'admin';
    final currentRoute = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final navHeight = screenHeight * 0.11;

    // Mock member data
    final memberName = 'PT CATERPILLAR';
    final memberDetails = {
      'memberCode': 'MEM-001',
      'legalStatus': 'Company (PT)',
      'memberName': memberName,
      'regAssets': 'Cannot register assets',
      'doSettings': 'DO Number Auto',
      'cpName': 'Sudirman (HR)',
      'cpNumber': '082123456789',
      'phone': '(0778) 396966',
      'phone2': '082123456789',
      'email': 'partner@caterpillar.com',
      'fax': '29425',
      'address': 'Jl. Brigjen Katamso No.76 - 78, Tj. Uncang, Kec. Batu Aji, Kota Batam, Kepulauan Riau',
      'remark': 'Industrial equipment supplier and distributor',
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
                  // Member Title with Edit Icon
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Assets.icons.people,
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            memberName,
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
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {
                            context.push('/edit-member/$memberId');
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

                  // Member Information Specifications
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: screenHeight * 0.03),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight * 0.01),
                        // Member Code
                        _buildDetailRow(
                          'Member Code',
                          memberDetails['memberCode']!,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // Legal Status
                        _buildDetailRow(
                          'Legal Status',
                          memberDetails['legalStatus']!,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // Member Name
                        _buildDetailRow(
                          'Member Name',
                          memberDetails['memberName']!,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // Reg Assets
                        _buildDetailRow(
                          'Reg Assets',
                          memberDetails['regAssets']!,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        // DO Settings
                        _buildDetailRow(
                          'DO Settings',
                          memberDetails['doSettings']!,
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

                  // Contact Information Section
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight * 0.01),
                        Text(
                          'Contact Information',
                          style: TextStyle(
                            color: const Color(0xFF353535),
                            fontSize: 20,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w700,
                            height: 1.20,
                            letterSpacing: -0.40,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        _buildDetailRow(
                          'Contact Person',
                          memberDetails['cpName']!,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        _buildDetailRow(
                          'Phone Number',
                          memberDetails['cpNumber']!,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        _buildDetailRow(
                          'Phone',
                          memberDetails['phone']!,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        _buildDetailRow(
                          'Phone 2',
                          memberDetails['phone2']!,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        _buildDetailRow(
                          'Email',
                          memberDetails['email']!,
                          screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        _buildDetailRow(
                          'Fax',
                          memberDetails['fax']!,
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

                  // Address Section
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          'Address',
                          style: TextStyle(
                            color: const Color(0xFF353535),
                            fontSize: 20,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w700,
                            height: 1.20,
                            letterSpacing: -0.40,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          memberDetails['address']!,
                          style: TextStyle(
                            color: const Color(0xFF677487),
                            fontSize: 14,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w400,
                            height: 1.40,
                            letterSpacing: -0.28,
                          ),
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

                  // Member Remark Section
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          'Member Remark',
                          style: TextStyle(
                            color: const Color(0xFF353535),
                            fontSize: 20,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w700,
                            height: 1.20,
                            letterSpacing: -0.40,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Text(
                          memberDetails['remark']!,
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
                        onTap: () => context.pop(),
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
                          'Member Detail',
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
