import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaspi_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';
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
    final memberData = {
      'name': 'PT CATERPILLAR',
      'code': 'CATB',
      'legalStatus': 'Company',
      'regAssets': 'Cannot register assets',
      'doSettings': 'DO Number Auto',
      'cpName': 'Sudirman (HR)',
      'cpNumber': '082123456789',
      'phone': '(0778) 396966',
      'phone2': '082123456789',
      'email': 'partner@caterpillar.com',
      'fax': '29425',
      'address': 'Jl. Brigjen Katamso No.76 - 78, Tj. Uncang, Kec. Batu Aji, Kota Batam, Kepulauan Riau',
      'remark': '-',
    };

    return Scaffold(
      backgroundColor: Colors.white,
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
                  // Header with Back Button
                  SizedBox(
                    width: double.infinity,
                    height: screenWidth * 0.097,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: screenWidth * 0.062,
                            height: screenWidth * 0.062,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              size: screenWidth * 0.051,
                              color: const Color(0xFF101828),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.031),
                        Expanded(
                          child: Text(
                            'Member Detail',
                            style: TextStyle(
                              color: const Color(0xFF191D0B),
                              fontSize: screenWidth * 0.041,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w700,
                              height: 1.10,
                              letterSpacing: -0.32,
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
                  // Member Name Card
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: screenHeight * 0.028),
                    child: Text(
                      memberData['name']!,
                      style: TextStyle(
                        color: const Color(0xFF101828),
                        fontSize: screenWidth * 0.051,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w700,
                        height: 1.20,
                        letterSpacing: -0.60,
                      ),
                    ),
                  ),

                  // Detail Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(screenWidth * 0.062),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFFEDEDED),
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x0C000000),
                          blurRadius: 71,
                          offset: Offset(0, 0),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Member Information Section
                        _buildDetailSection(
                          context,
                          title: 'Member Information',
                          items: [
                            _buildDetailRow('Memb. Code', memberData['code']!),
                            _buildDetailRow('Legal Status', memberData['legalStatus']!),
                            _buildDetailRow('Memb. Name', memberData['name']!),
                            _buildDetailRow('Reg Assets', memberData['regAssets']!),
                            _buildDetailRow('DO Settings', memberData['doSettings']!),
                          ],
                        ),

                        SizedBox(height: screenHeight * 0.019),

                        // Divider
                        Container(
                          width: double.infinity,
                          height: screenHeight * 0.0005,
                          color: const Color(0xFFEDEDED),
                        ),

                        SizedBox(height: screenHeight * 0.019),

                        // Contact Person Section
                        _buildDetailSection(
                          context,
                          title: 'Contact Person',
                          items: [
                            _buildDetailRow('Name', memberData['cpName']!),
                            _buildDetailRow('Number', memberData['cpNumber']!),
                          ],
                        ),

                        SizedBox(height: screenHeight * 0.019),

                        // Divider
                        Container(
                          width: double.infinity,
                          height: screenHeight * 0.0005,
                          color: const Color(0xFFEDEDED),
                        ),

                        SizedBox(height: screenHeight * 0.019),

                        // Contact & Address Section
                        _buildDetailSection(
                          context,
                          title: 'Contact & Address',
                          items: [
                            _buildDetailRow('Phone', memberData['phone']!),
                            _buildDetailRow('Phone 2', memberData['phone2']!),
                            _buildDetailRow('Email', memberData['email']!),
                            _buildDetailRow('Fax', memberData['fax']!),
                            _buildDetailRow('Address', memberData['address']!),
                          ],
                        ),

                        SizedBox(height: screenHeight * 0.028),

                        // Member Remark Section
                        _buildDetailSection(
                          context,
                          title: 'Member Remark',
                          isRemark: true,
                          remark: memberData['remark']!,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),
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

  Widget _buildDetailSection(
    BuildContext context, {
    required String title,
    List<Widget>? items,
    bool isRemark = false,
    String? remark,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
        SizedBox(height: screenHeight * 0.019),
        if (isRemark)
          Text(
            remark ?? '-',
            style: TextStyle(
              color: const Color(0xFF677487),
              fontSize: screenWidth * 0.036,
              fontFamily: 'Nunito Sans',
              fontWeight: FontWeight.w400,
              height: 1.40,
              letterSpacing: -0.28,
            ),
          )
        else
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items ?? [],
          ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Builder(
      builder: (context) {
        final screenWidth = MediaQuery.of(context).size.width;
        final screenHeight = MediaQuery.of(context).size.height;

        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: screenHeight * 0.009),
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
              SizedBox(width: screenWidth * 0.031),
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
          ),
        );
      },
    );
  }
}
