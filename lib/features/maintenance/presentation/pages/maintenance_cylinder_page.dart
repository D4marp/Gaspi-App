import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gaspi_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:gaspi_app/features/home/presentation/widgets/role_based_bottom_navigation.dart';
import 'package:gaspi_app/features/maintenance/data/models/maintenance_cylinder_model.dart';
import 'package:gaspi_app/features/maintenance/presentation/widgets/maintenance_list_item_widget.dart';
import 'package:gaspi_app/features/maintenance/presentation/widgets/maintenance_filter_bar_widget.dart';
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

    double sw(double px) => px / 390 * screenWidth;
    double sh(double px) => px / 844 * screenHeight;

    final items = getFilteredAndPaginatedItems();
    final totalPages = getTotalPages();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          // Main content
          SingleChildScrollView(
            child: Column(
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: sh(48),
                    left: sw(32),
                    right: sw(32),
                    bottom: sh(20),
                  ),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cylinder Maintenance',
                        style: TextStyle(
                          color: const Color(0xFF191D0B),
                          fontSize: sw(16),
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: sh(16)),
                      // Filters
                      MaintenanceFilterBarWidget(
                        searchHint: 'Search Cylinder No',
                        searchController: searchController,
                        onSearchChanged: (value) {
                          setState(() {
                            currentPage = 1;
                          });
                        },
                        filterOptions: ['Pending', 'On Process', 'Completed'],
                        selectedFilter: selectedFilter,
                        onFilterChanged: (value) {
                          setState(() {
                            selectedFilter = value;
                            currentPage = 1;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                // List items
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: sw(20),
                    vertical: sh(20),
                  ),
                  child: Column(
                    children: items.isEmpty
                        ? [
                            SizedBox(height: sh(50)),
                            Text(
                              'No items found',
                              style: TextStyle(
                                color: const Color(0xFF999999),
                                fontSize: sw(14),
                                fontFamily: 'Nunito Sans',
                              ),
                            ),
                          ]
                        : items
                            .map((item) => MaintenanceListItemWidget(
                                  id: item.id,
                                  status: item.status,
                                  statusColor: item.statusColor,
                                  dateTime: item.dateTime,
                                  subtitle: item.registeredFor,
                                  onTap: () {
                                    context.push('/maintenance/cylinder/${item.id}');
                                  },
                                ))
                            .toList(),
                  ),
                ),

                // Pagination
                if (totalPages > 0)
                  MaintenancePaginationWidget(
                    currentPage: currentPage,
                    totalPages: totalPages,
                    onPageChanged: (page) {
                      setState(() {
                        currentPage = page;
                      });
                    },
                  ),

                SizedBox(height: sh(100)),
              ],
            ),
          ),

          // Bottom navigation
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
