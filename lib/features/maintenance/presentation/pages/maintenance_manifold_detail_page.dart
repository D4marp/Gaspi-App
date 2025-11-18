import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaspi_app/features/home/presentation/widgets/role_based_bottom_navigation.dart';
import 'package:gaspi_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';

class MaintenanceManifoldDetailPage extends ConsumerWidget {
  final String manifoldId;

  const MaintenanceManifoldDetailPage({super.key, this.manifoldId = '2141412'});

  // Helper: scale by screen width
  double _sw(BuildContext c, double px) => px / 390 * MediaQuery.of(c).size.width;
  double _sh(BuildContext c, double px) => px / 844 * MediaQuery.of(c).size.height;

  Widget _labelText(String text, {bool required = false}) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: text),
          if (required)
            TextSpan(
              text: '*',
              style: const TextStyle(color: Color(0xFFF1003C)),
            ),
        ],
      ),
      style: const TextStyle(
        color: Color(0xFF101828),
        fontSize: 14,
        fontFamily: 'Nunito Sans',
        fontWeight: FontWeight.w400,
        height: 1.40,
        letterSpacing: -0.28,
      ),
    );
  }

  Widget _field(BuildContext context, String value, {bool isDisabled = false, Widget? trailing}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: _sh(context, 10), horizontal: _sw(context, 24)),
      decoration: BoxDecoration(
        color: isDisabled ? const Color(0xFFF5F5F5) : Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFFEDEDED), width: 1.0),
        boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: value == 'Select Process' || value == 'Select Maintenance Status' || value == 'Manifold Remark'
                    ? const Color(0xFF68686D)
                    : const Color(0xFF101828),
                fontSize: _sw(context, 14),
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final userRole = user?.role.value ?? 'production';
    final currentRoute = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          // Main white card
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: _sh(context, 110)),
                child: SingleChildScrollView(
                  child: Container(
                    width: _sw(context, 390),
                    padding: EdgeInsets.all(_sw(context, 24)),
                    margin: EdgeInsets.only(bottom: _sh(context, 100)),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      shadows: const [
                        BoxShadow(color: Color(0x0C000000), blurRadius: 71, offset: Offset(0, 0)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Manifold $manifoldId',
                          style: TextStyle(
                            color: const Color(0xFF101828),
                            fontSize: _sw(context, 20),
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w700,
                            height: 1.20,
                            letterSpacing: -0.60,
                          ),
                        ),
                        SizedBox(height: _sh(context, 24)),

                        // Fields
                        _labelText('Registered Manifold No', required: true),
                        SizedBox(height: _sh(context, 8)),
                        _field(context, '251231', isDisabled: true),
                        SizedBox(height: _sh(context, 24)),

                        _labelText('Registered Transport Rack No', required: true),
                        SizedBox(height: _sh(context, 8)),
                        _field(context, 'Select Registered Transport Rack', trailing: Container(width: _sw(context, 14), height: _sh(context, 14))),
                        SizedBox(height: _sh(context, 24)),

                        _labelText('Type'),
                        SizedBox(height: _sh(context, 8)),
                        _field(context, 'Oxygen (O2)', isDisabled: true),
                        SizedBox(height: _sh(context, 24)),

                        _labelText('Manifold Material'),
                        SizedBox(height: _sh(context, 8)),
                        _field(context, 'Cooper', isDisabled: true),
                        SizedBox(height: _sh(context, 24)),

                        _labelText('Capacity'),
                        SizedBox(height: _sh(context, 8)),
                        _field(context, '12 Cylinder', isDisabled: true),
                        SizedBox(height: _sh(context, 24)),

                        _labelText('Registered for'),
                        SizedBox(height: _sh(context, 8)),
                        _field(context, 'PT. Amnor Shipyard', isDisabled: true),
                        SizedBox(height: _sh(context, 24)),

                        _labelText('Process', required: true),
                        SizedBox(height: _sh(context, 8)),
                        _field(context, 'Select Process', trailing: Container(width: _sw(context, 14), height: _sh(context, 14))),
                        SizedBox(height: _sh(context, 24)),

                        _labelText('Status', required: true),
                        SizedBox(height: _sh(context, 8)),
                        _field(context, 'Select Maintenance Status', trailing: Container(width: _sw(context, 14), height: _sh(context, 14))),
                        SizedBox(height: _sh(context, 24)),

                        _labelText('Add Registered Cylinders into Manifold', required: true),
                        SizedBox(height: _sh(context, 8)),
                        _field(context, 'Select Cylinders for this Manifold', trailing: Container(width: _sw(context, 14), height: _sh(context, 14))),
                        SizedBox(height: _sh(context, 24)),

                        _labelText('Remark'),
                        SizedBox(height: _sh(context, 8)),
                        Container(
                          width: double.infinity,
                          height: _sh(context, 105),
                          padding: EdgeInsets.symmetric(horizontal: _sw(context, 16), vertical: _sh(context, 10)),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFEDEDED), width: 1.0),
                            boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2))],
                          ),
                          child: Text(
                            'Manifold Remark',
                            style: TextStyle(
                              color: const Color(0xFF68686D),
                              fontSize: _sw(context, 14),
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),

                        SizedBox(height: _sh(context, 24)),

                        // History label
                        Text(
                          'History',
                          style: TextStyle(
                            color: const Color(0xFF101828),
                            fontSize: _sw(context, 14),
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w400,
                            height: 1.40,
                            letterSpacing: -0.28,
                          ),
                        ),
                        SizedBox(height: _sh(context, 12)),

                        // History table with headers and rows
                        Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              // Header row
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: _sw(context, 12), vertical: _sh(context, 10)),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF9F9F9),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: const Color(0xFFEDEDED), width: 1.0),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: _sw(context, 30),
                                      child: Text(
                                        'No',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: _sw(context, 14),
                                          fontFamily: 'Nunito Sans',
                                          fontWeight: FontWeight.w400,
                                          height: 1.60,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: _sw(context, 8)),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Maintenance Type',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: _sw(context, 14),
                                          fontFamily: 'Nunito Sans',
                                          fontWeight: FontWeight.w400,
                                          height: 1.60,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: _sw(context, 8)),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Maintenance Date',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: _sw(context, 14),
                                          fontFamily: 'Nunito Sans',
                                          fontWeight: FontWeight.w400,
                                          height: 1.60,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: _sw(context, 8)),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Technician',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: _sw(context, 14),
                                          fontFamily: 'Nunito Sans',
                                          fontWeight: FontWeight.w400,
                                          height: 1.60,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: _sh(context, 8)),
                              // History rows
                              ...[
                                {'type': 'Calibration', 'date': '25/02/2025', 'tech': 'Thruston Moore'},
                                {'type': 'Seal Replacement', 'date': '25/02/2025', 'tech': 'Thruston Moore'},
                                {'type': 'Pressure Test', 'date': '25/02/2025', 'tech': 'Thruston Moore'},
                              ].asMap().entries.map((entry) {
                                int index = entry.key + 1;
                                Map<String, String> data = entry.value;
                                return Padding(
                                  padding: EdgeInsets.only(bottom: _sh(context, 8)),
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(horizontal: _sw(context, 12), vertical: _sh(context, 10)),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: const Color(0xFFEDEDED), width: 1.0),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: _sw(context, 30),
                                          child: Text(
                                            '$index',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: _sw(context, 14),
                                              fontFamily: 'Nunito Sans',
                                              fontWeight: FontWeight.w400,
                                              height: 1.60,
                                              letterSpacing: -0.28,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: _sw(context, 8)),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            data['type']!,
                                            style: TextStyle(
                                              color: const Color(0xFF101828),
                                              fontSize: _sw(context, 14),
                                              fontFamily: 'Nunito Sans',
                                              fontWeight: FontWeight.w400,
                                              height: 1.60,
                                              letterSpacing: -0.28,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: _sw(context, 8)),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            data['date']!,
                                            style: TextStyle(
                                              color: const Color(0xFF101828),
                                              fontSize: _sw(context, 14),
                                              fontFamily: 'Nunito Sans',
                                              fontWeight: FontWeight.w400,
                                              height: 1.60,
                                              letterSpacing: -0.28,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: _sw(context, 8)),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            data['tech']!,
                                            style: TextStyle(
                                              color: const Color(0xFF101828),
                                              fontSize: _sw(context, 14),
                                              fontFamily: 'Nunito Sans',
                                              fontWeight: FontWeight.w400,
                                              height: 1.60,
                                              letterSpacing: -0.28,
                                            ),
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

                        SizedBox(height: _sh(context, 24)),

                        // Update button
                        GestureDetector(
                          onTap: () {
                            // handle update
                          },
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: _sw(context, 20), vertical: _sh(context, 12)),
                            decoration: BoxDecoration(
                              color: const Color(0xFF007EFF),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              'Update Maintenance Status',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: _sw(context, 16),
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: _sh(context, 24)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Top header
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: _sh(context, 48),
                left: _sw(context, 32),
                right: _sw(context, 32),
                bottom: _sh(context, 12),
              ),
              color: Colors.white,
              child: Row(
                children: [
                  SizedBox(width: _sw(context, 24), height: _sh(context, 24)),
                  Expanded(
                    child: Text(
                      'Manifold Maintenance',
                      style: TextStyle(
                        color: const Color(0xFF191D0B),
                        fontSize: _sw(context, 16),
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
          ),

          // Bottom navigation
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: RoleBasedBottomNavigation(currentRoute: currentRoute, userRole: userRole),
          ),
        ],
      ),
    );
  }
}
