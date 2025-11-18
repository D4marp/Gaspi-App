import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaspi_app/features/home/presentation/widgets/role_based_bottom_navigation.dart';
import 'package:gaspi_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';

class MaintenanceDetailPage extends ConsumerWidget {
  final String cylinderNo;

  const MaintenanceDetailPage({super.key, this.cylinderNo = '2141412'});

  // Helper: scale by screen width
  double _sw(BuildContext c, double px) => px / 390 * MediaQuery.of(c).size.width;
  double _sh(BuildContext c, double px) => px / 844 * MediaQuery.of(c).size.height;

  Widget _labelText(String text) {
    return Text.rich(
      TextSpan(children: [TextSpan(text: text)]),
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
                color: const Color(0xFF101828),
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

  // MediaQuery sizes used via helpers _sw/_sh when needed

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
                child: Container(
                  width: _sw(context, 390),
                  // height will grow naturally
                  padding: EdgeInsets.all(_sw(context, 24)),
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
                        'Cylinder $cylinderNo',
                        style: TextStyle(
                          color: const Color(0xFF101828),
                          fontSize: _sw(context, 20),
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w700,
                          height: 1.20,
                        ),
                      ),
                      SizedBox(height: _sh(context, 24)),

                      // Fields
                      _labelText('Cylinder No'),
                      SizedBox(height: _sh(context, 8)),
                      _field(context, '251246', isDisabled: true),
                      SizedBox(height: _sh(context, 16)),

                      _labelText('Registered for'),
                      SizedBox(height: _sh(context, 8)),
                      _field(context, 'PT. Amnor Shipyard', isDisabled: true),
                      SizedBox(height: _sh(context, 16)),

                      _labelText('Process'),
                      SizedBox(height: _sh(context, 8)),
                      _field(context, 'Select Process', trailing: Container(width: _sw(context, 14), height: _sh(context, 14))),
                      SizedBox(height: _sh(context, 16)),

                      _labelText('Conversion'),
                      SizedBox(height: _sh(context, 8)),
                      _field(context, 'Yes, It\'s Conversion', trailing: Container(width: _sw(context, 14), height: _sh(context, 14))),
                      SizedBox(height: _sh(context, 16)),

                      _labelText('Convert to'),
                      SizedBox(height: _sh(context, 8)),
                      _field(context, 'Oxygen (O2)', trailing: Container(width: _sw(context, 14), height: _sh(context, 14))),
                      SizedBox(height: _sh(context, 16)),

                      _labelText('Status'),
                      SizedBox(height: _sh(context, 8)),
                      _field(context, 'Select Maintenance Status', trailing: Container(width: _sw(context, 14), height: _sh(context, 14))),
                      SizedBox(height: _sh(context, 16)),

                      _labelText('Hydro Testing Date'),
                      SizedBox(height: _sh(context, 8)),
                      _field(context, '12/03/2024', trailing: Container(width: _sw(context, 14), height: _sh(context, 14))),
                      SizedBox(height: _sh(context, 16)),

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
                          'Painting Process',
                          style: TextStyle(color: const Color(0xFF101828), fontSize: _sw(context, 14)),
                        ),
                      ),

                      SizedBox(height: _sh(context, 24)),

                      // History label
                      Text(
                        'History',
                        style: TextStyle(color: const Color(0xFF101828), fontSize: _sw(context, 14)),
                      ),
                      SizedBox(height: _sh(context, 12)),

                      // History table-like (simple column of rows)
                      Container(
                        width: double.infinity,
                        child: Column(
                          children: List.generate(4, (index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: _sh(context, 8)),
                              child: Row(
                                children: [
                                  Container(
                                    width: _sw(context, 60),
                                    height: _sh(context, 42),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFAFAFA),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: const Color(0xFFEDEDED), width: 1.0),
                                    ),
                                    child: Text('${index + 1}'),
                                  ),
                                  SizedBox(width: _sw(context, 12)),
                                  Expanded(
                                    child: Container(
                                      height: _sh(context, 42),
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.symmetric(horizontal: _sw(context, 16)),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFAFAFA),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: const Color(0xFFEDEDED), width: 1.0),
                                      ),
                                      child: Text('Process - Convert from Argon to Oxygen'),
                                    ),
                                  ),
                                  SizedBox(width: _sw(context, 12)),
                                  Container(
                                    width: _sw(context, 120),
                                    height: _sh(context, 42),
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(horizontal: _sw(context, 16)),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFAFAFA),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: const Color(0xFFEDEDED), width: 1.0),
                                    ),
                                    child: Text('25/02/2025'),
                                  ),
                                ],
                              ),
                            );
                          }),
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
                            style: TextStyle(color: Colors.white, fontSize: _sw(context, 16), fontWeight: FontWeight.w700),
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

          // Top header
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: _sh(context, 48), left: _sw(context, 32), right: _sw(context, 32), bottom: _sh(context, 12)),
              color: Colors.white,
              child: Row(
                children: [
                  SizedBox(width: _sw(context, 24), height: _sh(context, 24)),
                  Expanded(
                    child: Text(
                      'Cylinder Maintenance',
                      style: TextStyle(color: const Color(0xFF191D0B), fontSize: _sw(context, 16), fontWeight: FontWeight.w700),
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

