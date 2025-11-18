import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../auth/presentation/providers/auth_provider.dart';
import '../../widgets/role_based_bottom_navigation.dart';

class EditAssetPage extends ConsumerStatefulWidget {
  final String assetId;

  const EditAssetPage({
    super.key,
    required this.assetId,
  });

  @override
  ConsumerState<EditAssetPage> createState() => _EditAssetPageState();
}

class _EditAssetPageState extends ConsumerState<EditAssetPage> {
  String? selectedRegisteredFor;
  String? selectedWaterCapacity;
  String? selectedManufacture;
  String? selectedGasType;
  String? selectedGasCapacityUnit;
  String? selectedOwner;

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
                  SizedBox(
                    width: double.infinity,
                    height: 38,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
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
                              size: 24,
                              color: Color(0xFF393D4E),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Edit Cylinder Assets',
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
                  ),
                ],
              ),
            ),
          ),

          // Main Content - Scrollable
          Positioned(
            left: screenWidth * 0.082,
            top: screenHeight * 0.14,
            right: screenWidth * 0.082,
            bottom: 0,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.25),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x0C000000),
                        blurRadius: 71,
                        offset: Offset(0, 0),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Cylinder Title
                      Text(
                        'Cylinder ${widget.assetId}',
                        style: const TextStyle(
                          color: Color(0xFF101828),
                          fontSize: 20,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w700,
                          height: 1.20,
                          letterSpacing: -0.60,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Asset Information Section
                      const Text(
                        'Asset Information',
                        style: TextStyle(
                          color: Color(0xFF353535),
                          fontSize: 16,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w700,
                          height: 1.20,
                          letterSpacing: -0.32,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Form Fields
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Cylinder Number Field (Disabled)
                            _buildDisabledField(
                              'Cylinder Number',
                              widget.assetId,
                            ),
                            const SizedBox(height: 24),

                            // Register For Field
                            _buildDropdownField(
                              'Register For',
                              selectedRegisteredFor ?? 'PT. Gaspi Cipta Nusantara',
                              onTap: () {
                                // TODO: Open registered for modal
                              },
                            ),
                            const SizedBox(height: 24),

                            // Water Capacity Field
                            _buildDropdownField(
                              'Water Capacity',
                              selectedWaterCapacity ?? '40 L',
                              onTap: () {
                                // TODO: Open water capacity modal
                              },
                            ),
                            const SizedBox(height: 24),

                            // Manufacture Brand Field
                            _buildFormField(
                              'Manufacture Brand',
                              'IDS',
                            ),
                            const SizedBox(height: 24),

                            // Working Pressure Field
                            _buildFormField(
                              'Working Pressure',
                              '40',
                            ),
                            const SizedBox(height: 24),

                            // Testing Pressure Field
                            _buildFormField(
                              'Testing Pressure',
                              '40',
                            ),
                            const SizedBox(height: 24),

                            // Purchase Date Field
                            _buildDropdownField(
                              'Purchase Date',
                              '12/2/2025',
                              onTap: () {
                                // TODO: Open date picker
                              },
                            ),
                            const SizedBox(height: 24),

                            // Testing Date Field
                            _buildDropdownField(
                              'Testing Date',
                              '12/2/2025',
                              onTap: () {
                                // TODO: Open date picker
                              },
                            ),
                            const SizedBox(height: 24),

                            // Tare Weight Field
                            _buildFormField(
                              'Tare Weight',
                              '30',
                            ),
                            const SizedBox(height: 24),

                            // MFG Certificate Field
                            _buildFormField(
                              'MFG Certificate',
                              '1824621391',
                            ),
                            const SizedBox(height: 24),

                            // Gas Type Field
                            _buildDropdownField(
                              'Gas Type',
                              selectedGasType ?? 'Oxygen (O2)',
                              onTap: () {
                                // TODO: Open gas type modal
                              },
                            ),
                            const SizedBox(height: 24),

                            // Gas Capacity Field (Number + Unit)
                            _buildGasCapacityField(),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Owner Information Section
                      const Text(
                        'Owner Information',
                        style: TextStyle(
                          color: Color(0xFF353535),
                          fontSize: 16,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w700,
                          height: 1.20,
                          letterSpacing: -0.32,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Item Owner Field
                      _buildDropdownField(
                        'Item Owner',
                        selectedOwner ?? 'Select Owner',
                        onTap: () {
                          // TODO: Open owner modal
                        },
                      ),
                      const SizedBox(height: 24),

                      // Owner Name Field
                      _buildFormField(
                        'Owner Name',
                        'Gaspi Waralaba Nusantara',
                      ),

                      const SizedBox(height: 32),

                      // Register Remark Section
                      const Text(
                        'Register Remark',
                        style: TextStyle(
                          color: Color(0xFF353535),
                          fontSize: 16,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w700,
                          height: 1.20,
                          letterSpacing: -0.32,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Remark Field
                      _buildTextAreaField(
                        'Remark',
                        '-',
                      ),

                      const SizedBox(height: 32),

                      // Update Button
                      GestureDetector(
                        onTap: () {
                          // TODO: Handle update cylinder
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF007EFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Update Cylinder Data',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Nunito Sans',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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

  Widget _buildFormField(
    String label,
    String placeholder,
  ) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$label ',
                  style: const TextStyle(
                    color: Color(0xFF353535),
                    fontSize: 14,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w600,
                    height: 1.20,
                    letterSpacing: -0.28,
                  ),
                ),
                const TextSpan(
                  text: '*',
                  style: TextStyle(
                    color: Color(0xFFD04B22),
                    fontSize: 14,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w600,
                    height: 1.20,
                    letterSpacing: -0.28,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 10,
              left: 16,
              right: 24,
              bottom: 10,
            ),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 0,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(32),
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
            child: TextField(
              controller: TextEditingController(text: placeholder),
              cursorColor: const Color(0xFF007EFF),
              style: const TextStyle(
                color: Color(0xFF353535),
                fontSize: 12,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.12,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisabledField(
    String label,
    String value,
  ) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$label ',
                  style: const TextStyle(
                    color: Color(0xFF353535),
                    fontSize: 14,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w600,
                    height: 1.20,
                    letterSpacing: -0.28,
                  ),
                ),
                const TextSpan(
                  text: '*',
                  style: TextStyle(
                    color: Color(0xFFD04B22),
                    fontSize: 14,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w600,
                    height: 1.20,
                    letterSpacing: -0.28,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 10,
              left: 16,
              right: 24,
              bottom: 10,
            ),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 0,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(32),
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
            child: Text(
              value,
              style: const TextStyle(
                color: Color(0xFF353535),
                fontSize: 12,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(
    String label,
    String placeholder, {
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '$label ',
                  style: const TextStyle(
                    color: Color(0xFF353535),
                    fontSize: 14,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w600,
                    height: 1.20,
                    letterSpacing: -0.28,
                  ),
                ),
                const TextSpan(
                  text: '*',
                  style: TextStyle(
                    color: Color(0xFFD04B22),
                    fontSize: 14,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w600,
                    height: 1.20,
                    letterSpacing: -0.28,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: 10,
                left: 24,
                right: 16,
                bottom: 10,
              ),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 0,
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(32),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      placeholder,
                      style: const TextStyle(
                        color: Color(0xFF101828),
                        fontSize: 12,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w400,
                        height: 1.40,
                        letterSpacing: -0.24,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.expand_more,
                    size: 14,
                    color: Color(0xFF68686D),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGasCapacityField() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: const [
                TextSpan(
                  text: 'Gas Capacity ',
                  style: TextStyle(
                    color: Color(0xFF353535),
                    fontSize: 14,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w600,
                    height: 1.20,
                    letterSpacing: -0.28,
                  ),
                ),
                TextSpan(
                  text: '*',
                  style: TextStyle(
                    color: Color(0xFFD04B22),
                    fontSize: 14,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w600,
                    height: 1.20,
                    letterSpacing: -0.28,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 80,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 0,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(32),
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
                child: TextField(
                  controller: TextEditingController(text: '30'),
                  cursorColor: const Color(0xFF007EFF),
                  style: const TextStyle(
                    color: Color(0xFF353535),
                    fontSize: 12,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w400,
                    height: 1.40,
                    letterSpacing: -0.12,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // TODO: Open gas capacity unit modal
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 24,
                      right: 16,
                      bottom: 10,
                    ),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 0,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(32),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Metre Cube (m3)',
                          style: TextStyle(
                            color: Color(0xFF101828),
                            fontSize: 12,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w400,
                            height: 1.40,
                            letterSpacing: -0.24,
                          ),
                        ),
                        Icon(
                          Icons.expand_more,
                          size: 14,
                          color: Color(0xFF68686D),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextAreaField(
    String label,
    String placeholder,
  ) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF353535),
              fontSize: 14,
              fontFamily: 'Nunito Sans',
              fontWeight: FontWeight.w600,
              height: 1.20,
              letterSpacing: -0.28,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            height: 112,
            padding: const EdgeInsets.all(12),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 0,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(12),
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
            child: TextField(
              maxLines: null,
              controller: TextEditingController(text: placeholder),
              cursorColor: const Color(0xFF007EFF),
              style: const TextStyle(
                color: Color(0xFF353535),
                fontSize: 12,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.12,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
