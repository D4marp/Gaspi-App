import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gaspi_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:gaspi_app/features/home/presentation/widgets/role_based_bottom_navigation.dart';
import 'package:gaspi_app/features/maintenance/data/models/maintenance_cylinder_model.dart';
import 'package:gaspi_app/features/maintenance/presentation/widgets/maintenance_pagination_widget.dart';

class MaintenanceCylinderPage extends ConsumerStatefulWidget {
  const MaintenanceCylinderPage({super.key});

  @override
  ConsumerState<MaintenanceCylinderPage> createState() => _MaintenanceCylinderPageState();
}

class _MaintenanceCylinderPageState extends ConsumerState<MaintenanceCylinderPage> {
  int currentPage = 1;
  String? selectedFilter;
  final TextEditingController searchController = TextEditingController();
  final int itemsPerPage = 5;

  // Sample data - ready for API integration
  final List<MaintenanceCylinder> allItems = [
    MaintenanceCylinder(
      id: '251234',
      status: 'Pending',
      statusColor: const Color(0xFFF1003C),
      dateTime: '03:16 | 18 Sep 2022',
      registeredFor: 'PT. Amnor Shipyard',
      process: 'Convert from Argon to Oxygen',
      isConversion: true,
      convertTo: 'Oxygen (O2)',
      hydroTestingDate: '12/03/2024',
      history: [
        MaintenanceHistory(entryNo: 1, action: 'Initiated', actionDate: '18/09/2022'),
        MaintenanceHistory(entryNo: 2, action: 'Inspection', actionDate: '19/09/2022'),
      ],
      remark: 'Initial inspection required',
    ),
    MaintenanceCylinder(
      id: '251233',
      status: 'On Process',
      statusColor: const Color(0xFFFF7F00),
      dateTime: '02:45 | 17 Sep 2022',
      registeredFor: 'PT. Sinar Jaya',
      process: 'Regular maintenance',
      isConversion: false,
      convertTo: 'N/A',
      hydroTestingDate: '10/03/2024',
      history: [
        MaintenanceHistory(entryNo: 1, action: 'Started', actionDate: '17/09/2022'),
      ],
    ),
    MaintenanceCylinder(
      id: '251232',
      status: 'Completed',
      statusColor: const Color(0xFF00B857),
      dateTime: '01:30 | 17 Sep 2022',
      registeredFor: 'PT. Global Supply',
      process: 'Convert to Nitrogen',
      isConversion: true,
      convertTo: 'Nitrogen (N2)',
      hydroTestingDate: '08/03/2024',
      history: [
        MaintenanceHistory(entryNo: 1, action: 'Completed', actionDate: '17/09/2022'),
      ],
    ),
    MaintenanceCylinder(
      id: '251231',
      status: 'Pending',
      statusColor: const Color(0xFFF1003C),
      dateTime: '04:20 | 16 Sep 2022',
      registeredFor: 'PT. Amnor Shipyard',
      process: 'Hydro testing',
      isConversion: false,
      convertTo: 'N/A',
      hydroTestingDate: '15/03/2024',
      history: [],
    ),
    MaintenanceCylinder(
      id: '251230',
      status: 'On Process',
      statusColor: const Color(0xFFFF7F00),
      dateTime: '05:10 | 16 Sep 2022',
      registeredFor: 'PT. Sinar Jaya',
      process: 'Painting',
      isConversion: false,
      convertTo: 'N/A',
      hydroTestingDate: '20/03/2024',
      history: [],
    ),
  ];

  /// Get filtered and paginated items
  List<MaintenanceCylinder> getFilteredAndPaginatedItems() {
    List<MaintenanceCylinder> filtered = allItems;

    // Apply search filter
    if (searchController.text.isNotEmpty) {
      final query = searchController.text.toLowerCase();
      filtered = filtered
          .where((item) =>
              item.id.toLowerCase().contains(query) ||
              item.registeredFor.toLowerCase().contains(query))
          .toList();
    }

    // Apply status filter
    if (selectedFilter != null) {
      filtered = filtered.where((item) => item.status == selectedFilter).toList();
    }

    // Apply pagination
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage).clamp(0, filtered.length);

    return filtered.sublist(startIndex, endIndex);
  }

  int getTotalPages() {
    List<MaintenanceCylinder> filtered = allItems;

    if (searchController.text.isNotEmpty) {
      final query = searchController.text.toLowerCase();
      filtered = filtered
          .where((item) =>
              item.id.toLowerCase().contains(query) ||
              item.registeredFor.toLowerCase().contains(query))
          .toList();
    }

    if (selectedFilter != null) {
      filtered = filtered.where((item) => item.status == selectedFilter).toList();
    }

    return (filtered.length / itemsPerPage).ceil();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final userRole = user?.role.value ?? 'production';
    final currentRoute = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final navHeight = screenHeight * 0.11;

    final items = getFilteredAndPaginatedItems();
    final totalPages = getTotalPages();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          // Main Content Area with List
          Positioned(
            left: screenWidth * 0.08,
            top: screenHeight * 0.21,
            right: screenWidth * 0.08,
            bottom: navHeight + (screenHeight * 0.02),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cylinder Maintenance List',
                    style: TextStyle(
                      color: const Color(0xFF101828),
                      fontSize: screenWidth * 0.052,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w700,
                      height: 1.10,
                      letterSpacing: -0.40,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: items.isEmpty
                        ? [
                            SizedBox(height: screenHeight * 0.05),
                            Text(
                              'No items found',
                              style: TextStyle(
                                color: const Color(0xFF999999),
                                fontSize: 14,
                                fontFamily: 'Nunito Sans',
                              ),
                            ),
                          ]
                        : List.generate(
                            items.length,
                            (index) {
                              final item = items[index];
                              return GestureDetector(
                                onTap: () => context.push('/maintenance/cylinder/${item.id}'),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.id,
                                          style: const TextStyle(
                                            color: Color(0xFF353535),
                                            fontSize: 14,
                                            fontFamily: 'Nunito Sans',
                                            fontWeight: FontWeight.w600,
                                            height: 1.40,
                                            letterSpacing: -0.28,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 1,
                                                color: item.statusColor,
                                              ),
                                              borderRadius: BorderRadius.circular(32),
                                            ),
                                          ),
                                          child: Text(
                                            item.status,
                                            style: TextStyle(
                                              color: item.statusColor,
                                              fontSize: 12,
                                              fontFamily: 'Nunito Sans',
                                              fontWeight: FontWeight.w600,
                                              height: 1.40,
                                              letterSpacing: -0.24,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.008),
                                    Text(
                                      item.dateTime,
                                      style: const TextStyle(
                                        color: Color(0xFF677487),
                                        fontSize: 14,
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w400,
                                        height: 1.40,
                                        letterSpacing: -0.28,
                                      ),
                                    ),
                                    if (index < items.length - 1)
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                                        child: const Divider(
                                          color: Color(0xFFEDEDED),
                                          thickness: 1,
                                          height: 1,
                                        ),
                                      )
                                    else
                                      SizedBox(height: screenHeight * 0.015),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                  if (totalPages > 0) ...[
                    SizedBox(height: screenHeight * 0.02),
                    MaintenancePaginationWidget(
                      currentPage: currentPage,
                      totalPages: totalPages,
                      onPageChanged: (page) {
                        setState(() {
                          currentPage = page;
                        });
                      },
                    ),
                  ],
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
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.015),
                  // Search and Notification
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: screenHeight * 0.045,
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04,
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
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search,
                                size: screenWidth * 0.045,
                                color: const Color(0xFF9C9C9C),
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              Expanded(
                                child: TextField(
                                  controller: searchController,
                                  onChanged: (value) {
                                    setState(() {
                                      currentPage = 1;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Search at Cylinder Maintenance',
                                    hintStyle: TextStyle(
                                      color: const Color(0xFF9C9C9C),
                                      fontSize: screenWidth * 0.03,
                                      fontFamily: 'Nunito Sans',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -0.12,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                    isDense: true,
                                  ),
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.03,
                                    fontFamily: 'Nunito Sans',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  // Filter Pills
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Latest Button (Active)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.06,
                            vertical: screenHeight * 0.008,
                          ),
                          decoration: ShapeDecoration(
                            color: selectedFilter == null ? const Color(0xFF007EFF) : Colors.white,
                            shape: RoundedRectangleBorder(
                              side: selectedFilter == null 
                                  ? const BorderSide(width: 0, color: Color(0xFF007EFF))
                                  : const BorderSide(width: 1, color: Color(0xFFDCDBDB)),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedFilter = null;
                                currentPage = 1;
                              });
                            },
                            child: Text(
                              'Latest',
                              style: TextStyle(
                                color: selectedFilter == null 
                                    ? Colors.white.withValues(alpha: 0.80)
                                    : const Color(0xCC777985),
                                fontSize: 12,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w600,
                                height: 1.40,
                                letterSpacing: -0.24,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        // Pending Button
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedFilter = selectedFilter == 'Pending' ? null : 'Pending';
                              currentPage = 1;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.06,
                              vertical: screenHeight * 0.008,
                            ),
                            decoration: ShapeDecoration(
                              color: selectedFilter == 'Pending' ? const Color(0xFF007EFF) : Colors.white,
                              shape: RoundedRectangleBorder(
                                side: selectedFilter == 'Pending'
                                    ? const BorderSide(width: 0, color: Color(0xFF007EFF))
                                    : const BorderSide(width: 1, color: Color(0xFFDCDBDB)),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'Pending',
                              style: TextStyle(
                                color: selectedFilter == 'Pending'
                                    ? Colors.white.withValues(alpha: 0.80)
                                    : const Color(0xCC777985),
                                fontSize: 12,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w600,
                                height: 1.40,
                                letterSpacing: -0.24,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        // On Process Button
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedFilter = selectedFilter == 'On Process' ? null : 'On Process';
                              currentPage = 1;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.06,
                              vertical: screenHeight * 0.008,
                            ),
                            decoration: ShapeDecoration(
                              color: selectedFilter == 'On Process' ? const Color(0xFF007EFF) : Colors.white,
                              shape: RoundedRectangleBorder(
                                side: selectedFilter == 'On Process'
                                    ? const BorderSide(width: 0, color: Color(0xFF007EFF))
                                    : const BorderSide(width: 1, color: Color(0xFFDCDBDB)),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'On Process',
                              style: TextStyle(
                                color: selectedFilter == 'On Process'
                                    ? Colors.white.withValues(alpha: 0.80)
                                    : const Color(0xCC777985),
                                fontSize: 12,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w600,
                                height: 1.40,
                                letterSpacing: -0.24,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        // Completed Button
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedFilter = selectedFilter == 'Completed' ? null : 'Completed';
                              currentPage = 1;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.06,
                              vertical: screenHeight * 0.008,
                            ),
                            decoration: ShapeDecoration(
                              color: selectedFilter == 'Completed' ? const Color(0xFF007EFF) : Colors.white,
                              shape: RoundedRectangleBorder(
                                side: selectedFilter == 'Completed'
                                    ? const BorderSide(width: 0, color: Color(0xFF007EFF))
                                    : const BorderSide(width: 1, color: Color(0xFFDCDBDB)),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'Completed',
                              style: TextStyle(
                                color: selectedFilter == 'Completed'
                                    ? Colors.white.withValues(alpha: 0.80)
                                    : const Color(0xCC777985),
                                fontSize: 12,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w600,
                                height: 1.40,
                                letterSpacing: -0.24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                ],
              ),
            ),
          ),

          // Bottom Navigation
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
}
