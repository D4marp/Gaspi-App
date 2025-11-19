import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaspi_app/features/home/presentation/widgets/role_based_bottom_navigation.dart';
import 'package:gaspi_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';

class MaintenanceDetailPage extends ConsumerWidget {
  final String cylinderNo;

  const MaintenanceDetailPage({super.key, this.cylinderNo = '2141412'});

  double _sw(BuildContext c, double px) => px / 390 * MediaQuery.of(c).size.width;
  double _sh(BuildContext c, double px) => px / 844 * MediaQuery.of(c).size.height;

  Widget _field(BuildContext context, String value, {bool isDisabled = false}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: _sh(context, 10), horizontal: _sw(context, 24)),
      decoration: BoxDecoration(
        color: isDisabled ? const Color(0xFFF5F5F5) : Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFFEDEDED), width: 1.0),
        boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Text(
        value,
        style: TextStyle(
          color: const Color(0xFF101828),
          fontSize: _sw(context, 14),
          fontFamily: 'Nunito Sans',
          fontWeight: FontWeight.w400,
        ),
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
      body: Column(
        children: [
          // Header
          Container(
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
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: _sw(context, 24),
                    color: const Color(0xFF191D0B),
                  ),
                ),
                SizedBox(width: _sw(context, 12)),
                Expanded(
                  child: Text(
                    'Cylinder Maintenance',
                    style: TextStyle(
                      color: const Color(0xFF191D0B),
                      fontSize: _sw(context, 16),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Main scrollable content
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(_sw(context, 32)),
                    child: Container(
                      width: double.infinity,
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

                          // Cylinder No
                          Text(
                            'Cylinder No',
                            style: TextStyle(
                              color: const Color(0xFF101828),
                              fontSize: _sw(context, 14),
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: _sh(context, 8)),
                          _field(context, '251246', isDisabled: true),
                          SizedBox(height: _sh(context, 16)),

                          // Registered for
                          Text(
                            'Registered for',
                            style: TextStyle(
                              color: const Color(0xFF101828),
                              fontSize: _sw(context, 14),
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: _sh(context, 8)),
                          _field(context, 'PT. Amnor Shipyard', isDisabled: true),
                          SizedBox(height: _sh(context, 16)),

                          // Process
                          Text(
                            'Process',
                            style: TextStyle(
                              color: const Color(0xFF101828),
                              fontSize: _sw(context, 14),
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: _sh(context, 8)),
                          _field(context, 'Convert from Argon to Oxygen', isDisabled: true),
                          SizedBox(height: _sh(context, 16)),

                          // Hydro Testing Date
                          Text(
                            'Hydro Testing Date',
                            style: TextStyle(
                              color: const Color(0xFF101828),
                              fontSize: _sw(context, 14),
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: _sh(context, 8)),
                          _field(context, '12/03/2024', isDisabled: true),
                          SizedBox(height: _sh(context, 24)),

                          // Update button
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: _sw(context, 20),
                                vertical: _sh(context, 12),
                              ),
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
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: _sh(context, 20)),
                ],
              ),
            ),
          ),

          // Bottom navigation
          RoleBasedBottomNavigation(
            currentRoute: currentRoute,
            userRole: userRole,
          ),
        ],
      ),
    );
  }
}
