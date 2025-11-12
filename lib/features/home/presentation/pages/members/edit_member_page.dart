import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../auth/presentation/providers/auth_provider.dart';
import '../../widgets/role_based_bottom_navigation.dart';

class EditMemberPage extends ConsumerStatefulWidget {
  final String memberId;

  const EditMemberPage({
    super.key,
    required this.memberId,
  });

  @override
  ConsumerState<EditMemberPage> createState() => _EditMemberPageState();
}

class _EditMemberPageState extends ConsumerState<EditMemberPage> {
  String? selectedLegalStatus;
  String? selectedRegistryAssets;
  String? selectedDOSetting;
  String? selectedCountry;
  String? selectedProvince;
  String? selectedCity;

  late TextEditingController _memberCodeController;
  late TextEditingController _memberNameController;
  late TextEditingController _contactPersonNameController;
  late TextEditingController _contactPersonPhoneController;
  late TextEditingController _phoneController;
  late TextEditingController _phone2Controller;
  late TextEditingController _emailController;
  late TextEditingController _faxController;
  late TextEditingController _addressController;
  late TextEditingController _remarkController;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadMemberData();
  }

  void _initializeControllers() {
    _memberCodeController = TextEditingController();
    _memberNameController = TextEditingController();
    _contactPersonNameController = TextEditingController();
    _contactPersonPhoneController = TextEditingController();
    _phoneController = TextEditingController();
    _phone2Controller = TextEditingController();
    _emailController = TextEditingController();
    _faxController = TextEditingController();
    _addressController = TextEditingController();
    _remarkController = TextEditingController();
  }

  void _loadMemberData() {
    // TODO: Load actual member data based on memberId
    // Mock data for now
    _memberCodeController.text = 'MEM-001';
    _memberNameController.text = 'PT CATERPILLAR';
    _contactPersonNameController.text = 'John Doe';
    _contactPersonPhoneController.text = '081234567890';
    _phoneController.text = '021-1234567';
    _phone2Controller.text = '021-7654321';
    _emailController.text = 'contact@caterpillar.co.id';
    _faxController.text = '021-1234568';
    selectedLegalStatus = 'PT (Perseroan Terbatas)';
    selectedRegistryAssets = 'Asset Registry 1';
    selectedDOSetting = 'DO Setting 1';
    selectedCountry = 'Indonesia';
    selectedProvince = 'DKI Jakarta';
    selectedCity = 'Jakarta Pusat';
    _addressController.text = 'Jl. Jenderal Sudirman No. 1, Jakarta';
    _remarkController.text = 'Major industrial equipment supplier';
  }

  @override
  void dispose() {
    _memberCodeController.dispose();
    _memberNameController.dispose();
    _contactPersonNameController.dispose();
    _contactPersonPhoneController.dispose();
    _phoneController.dispose();
    _phone2Controller.dispose();
    _emailController.dispose();
    _faxController.dispose();
    _addressController.dispose();
    _remarkController.dispose();
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
                    height: screenHeight * 0.05,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: Container(
                            width: screenWidth * 0.06,
                            height: screenWidth * 0.06,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              size: screenWidth * 0.06,
                              color: const Color(0xFF393D4E),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Expanded(
                          child: Text(
                            'Edit Member',
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
            top: screenHeight * 0.14,
            right: screenWidth * 0.082,
            bottom: 0,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: screenHeight * 0.25),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(screenWidth * 0.06),
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
                      Text(
                        'Edit Member',
                        style: TextStyle(
                          color: const Color(0xFF101828),
                          fontSize: screenWidth * 0.05,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w700,
                          height: 1.20,
                          letterSpacing: -0.60,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      // Member Information Section
                      _buildSectionTitle('Member Information', screenWidth),
                      SizedBox(height: screenHeight * 0.02),
                      _buildFormField('Member Code', 'Enter Member Code', _memberCodeController, screenWidth),
                      SizedBox(height: screenHeight * 0.02),
                      _buildFormField('Member Name', 'Enter Member Name', _memberNameController, screenWidth),
                      SizedBox(height: screenHeight * 0.02),
                      _buildImageUploadField('Logo', screenWidth),
                      SizedBox(height: screenHeight * 0.02),
                      _buildDropdownField(
                        'Legal Status',
                        selectedLegalStatus ?? 'Select Legal Status',
                        onTap: () {
                          // TODO: Open legal status modal
                        },
                        screenWidth: screenWidth,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildDropdownField(
                        'Registry Assets Setting',
                        selectedRegistryAssets ?? 'Select Registry Assets Setting',
                        onTap: () {
                          // TODO: Open registry assets modal
                        },
                        screenWidth: screenWidth,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildDropdownField(
                        'DO Setting',
                        selectedDOSetting ?? 'Select DO Setting',
                        onTap: () {
                          // TODO: Open DO setting modal
                        },
                        screenWidth: screenWidth,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      // Contact Person Section
                      _buildSectionTitle('Member Contact Person', screenWidth),
                      SizedBox(height: screenHeight * 0.02),
                      _buildFormField('Name', 'Enter Contact Person Name', _contactPersonNameController, screenWidth),
                      SizedBox(height: screenHeight * 0.02),
                      _buildFormField('Number', 'Enter Contact Person Number', _contactPersonPhoneController, screenWidth),
                      SizedBox(height: screenHeight * 0.03),
                      // Contact & Address Section
                      _buildSectionTitle('Member Contact & Address', screenWidth),
                      SizedBox(height: screenHeight * 0.02),
                      _buildFormField('Phone', 'Enter Customer Phone Number', _phoneController, screenWidth),
                      SizedBox(height: screenHeight * 0.02),
                      _buildFormField('Phone 2', 'Enter Other Customer Phone Number', _phone2Controller, screenWidth, isRequired: false),
                      SizedBox(height: screenHeight * 0.02),
                      _buildFormField('Email', 'Enter Customer Email', _emailController, screenWidth),
                      SizedBox(height: screenHeight * 0.02),
                      _buildFormField('Fax', 'Enter Customer Fax', _faxController, screenWidth),
                      SizedBox(height: screenHeight * 0.02),
                      _buildDropdownField(
                        'Country',
                        selectedCountry ?? 'Select Country',
                        onTap: () {
                          // TODO: Open country modal
                        },
                        screenWidth: screenWidth,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildDropdownField(
                        'Province',
                        selectedProvince ?? 'Select Province',
                        onTap: () {
                          // TODO: Open province modal
                        },
                        screenWidth: screenWidth,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildDropdownField(
                        'City',
                        selectedCity ?? 'Select City',
                        onTap: () {
                          // TODO: Open city modal
                        },
                        screenWidth: screenWidth,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildTextAreaField('Address', 'Enter Customer Address', _addressController, screenWidth),
                      SizedBox(height: screenHeight * 0.03),
                      // Member Remark Section
                      _buildSectionTitle('Member Remark', screenWidth),
                      SizedBox(height: screenHeight * 0.02),
                      _buildTextAreaField('Remark', 'Enter Customer Remark', _remarkController, screenWidth),
                      SizedBox(height: screenHeight * 0.03),
                      // Buttons Row
                      Row(
                        children: [
                          Expanded(
                            child: _buildDeleteButton('Delete', screenWidth),
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          Expanded(
                            child: _buildUpdateButton('Update Member', screenWidth),
                          ),
                        ],
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

  Widget _buildSectionTitle(String title, double screenWidth) {
    return Text(
      title,
      style: TextStyle(
        color: const Color(0xFF353535),
        fontSize: screenWidth * 0.04,
        fontFamily: 'Nunito Sans',
        fontWeight: FontWeight.w700,
        height: 1.20,
        letterSpacing: -0.32,
      ),
    );
  }

  Widget _buildFormField(
    String label,
    String placeholder,
    TextEditingController controller,
    double screenWidth, {
    bool isRequired = true,
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
                  style: TextStyle(
                    color: const Color(0xFF353535),
                    fontSize: screenWidth * 0.035,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w600,
                    height: 1.20,
                    letterSpacing: -0.28,
                  ),
                ),
                if (isRequired)
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
          SizedBox(height: screenWidth * 0.03),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06,
              vertical: screenWidth * 0.03,
            ),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1,
                  color: Color(0xFFF0F0F0),
                ),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: TextField(
              controller: controller,
              style: TextStyle(
                color: const Color(0xFF353535),
                fontSize: screenWidth * 0.03,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: TextStyle(
                  color: const Color(0xFF9C9C9C),
                  fontSize: screenWidth * 0.03,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.12,
                ),
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

  Widget _buildImageUploadField(String label, double screenWidth) {
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
                  style: TextStyle(
                    color: const Color(0xFF353535),
                    fontSize: screenWidth * 0.035,
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
          SizedBox(height: screenWidth * 0.03),
          GestureDetector(
            onTap: () {
              // TODO: Open image picker
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenWidth * 0.03,
              ),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 1.50,
                    color: Color(0xFFEDEDED),
                  ),
                  borderRadius: BorderRadius.circular(32),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 71,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFFEDEDED),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_outlined,
                          size: screenWidth * 0.04,
                          color: const Color(0xFF68686D),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          'Choose Image File (Jpg, Png, Bmp)',
                          style: TextStyle(
                            color: const Color(0xFF68686D),
                            fontSize: screenWidth * 0.035,
                            fontStyle: FontStyle.italic,
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
        ],
      ),
    );
  }

  Widget _buildDropdownField(
    String label,
    String placeholder, {
    required VoidCallback onTap,
    bool isRequired = true,
    required double screenWidth,
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
                  style: TextStyle(
                    color: const Color(0xFF353535),
                    fontSize: screenWidth * 0.035,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w600,
                    height: 1.20,
                    letterSpacing: -0.28,
                  ),
                ),
                if (isRequired)
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
          SizedBox(height: screenWidth * 0.03),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.06,
                vertical: screenWidth * 0.03,
              ),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 1.50,
                    color: Color(0xFFEDEDED),
                  ),
                  borderRadius: BorderRadius.circular(32),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 71,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                  )
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
                      style: TextStyle(
                        color: const Color(0xFF68686D),
                        fontSize: screenWidth * 0.03,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w400,
                        height: 1.40,
                        letterSpacing: -0.24,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.expand_more,
                    size: screenWidth * 0.035,
                    color: const Color(0xFF68686D),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextAreaField(
    String label,
    String placeholder,
    TextEditingController controller,
    double screenWidth, {
    bool isRequired = true,
  }) {
    final screenHeight = MediaQuery.of(context).size.height;
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
                  style: TextStyle(
                    color: const Color(0xFF353535),
                    fontSize: screenWidth * 0.035,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w600,
                    height: 1.20,
                    letterSpacing: -0.28,
                  ),
                ),
                if (isRequired)
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
          SizedBox(height: screenWidth * 0.03),
          Container(
            width: double.infinity,
            height: screenHeight * 0.15,
            padding: EdgeInsets.all(screenWidth * 0.06),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1,
                  color: Color(0xFFF0F0F0),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: TextField(
              controller: controller,
              maxLines: null,
              style: TextStyle(
                color: const Color(0xFF353535),
                fontSize: screenWidth * 0.03,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: placeholder,
                hintStyle: TextStyle(
                  color: const Color(0xFF9C9C9C),
                  fontSize: screenWidth * 0.03,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.12,
                ),
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

  Widget _buildUpdateButton(String text, double screenWidth) {
    return GestureDetector(
      onTap: () {
        // TODO: Update member
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Member updated successfully!')),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenWidth * 0.03,
        ),
        decoration: ShapeDecoration(
          color: const Color(0xFF007EFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.035,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeleteButton(String text, double screenWidth) {
    return GestureDetector(
      onTap: () {
        // TODO: Delete member with confirmation
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Member'),
            content: const Text('Are you sure you want to delete this member?'),
            actions: [
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  context.pop(); // Close dialog
                  context.pop(); // Go back to members list
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Member deleted successfully!')),
                  );
                },
                child: const Text('Delete', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenWidth * 0.03,
        ),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFFE53E3E), width: 1.5),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFFE53E3E),
                fontSize: screenWidth * 0.035,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
