import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gaspi_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:gaspi_app/features/home/presentation/widgets/role_based_bottom_navigation.dart';
import 'package:gaspi_app/features/maintenance/data/models/maintenance_manifold_model.dart';
import 'package:gaspi_app/features/maintenance/presentation/widgets/maintenance_list_item_widget.dart';
import 'package:gaspi_app/features/maintenance/presentation/widgets/maintenance_filter_bar_widget.dart';
import 'package:gaspi_app/features/maintenance/presentation/widgets/maintenance_pagination_widget.dart';

class MaintenanceManifoldPage extends ConsumerStatefulWidget {
  const MaintenanceManifoldPage({super.key});

  @override
  ConsumerState<MaintenanceManifoldPage> createState() => _MaintenanceManifoldPageState();
}

class _MaintenanceManifoldPageState extends ConsumerState<MaintenanceManifoldPage> {
  int currentPage = 1;
  String? selectedFilter;
  final TextEditingController searchController = TextEditingController();
  final int itemsPerPage = 5;

  // Sample data - ready for API integration
  final List<MaintenanceManifold> allItems = [
    MaintenanceManifold(
      id: '251234',
      status: 'Pending',
      statusColor: const Color(0xFFF1003C),
      dateTime: '03:16 | 18 Sep 2022',
      manifoldId: 'MF-001',
      manifoldType: 'Type A',
      portCount: 8,
      location: 'Control Room A',
      lastCalibrationDate: '10/09/2022',
      history: [
        MaintenanceManifoldHistory(
          entryNo: 1,
          maintenanceType: 'Calibration',
          maintenanceDate: '10/09/2022',
          technician: 'Mike Johnson',
        ),
      ],
      remark: 'Pressure calibration needed',
    ),
    MaintenanceManifold(
      id: '251233',
      status: 'On Process',
      statusColor: const Color(0xFFFF7F00),
      dateTime: '02:45 | 17 Sep 2022',
      manifoldId: 'MF-002',
      manifoldType: 'Type B',
      portCount: 12,
      location: 'Control Room B',
      lastCalibrationDate: '12/09/2022',
      history: [
        MaintenanceManifoldHistory(
          entryNo: 1,
          maintenanceType: 'Seal Replacement',
          maintenanceDate: '17/09/2022',
          technician: 'Sarah Lee',
        ),
      ],
    ),
    MaintenanceManifold(
      id: '251232',
      status: 'On Process',
      statusColor: const Color(0xFFFF7F00),
      dateTime: '01:30 | 17 Sep 2022',
      manifoldId: 'MF-003',
      manifoldType: 'Type A',
      portCount: 8,
      location: 'Control Room C',
      lastCalibrationDate: '11/09/2022',
      history: [],
    ),
    MaintenanceManifold(
      id: '251231',
      status: 'On Process',
      statusColor: const Color(0xFFFF7F00),
      dateTime: '04:20 | 16 Sep 2022',
      manifoldId: 'MF-004',
      manifoldType: 'Type C',
      portCount: 16,
      location: 'Control Room D',
      lastCalibrationDate: '09/09/2022',
      history: [],
    ),
    MaintenanceManifold(
      id: '251230',
      status: 'On Process',
      statusColor: const Color(0xFFFF7F00),
      dateTime: '05:10 | 16 Sep 2022',
      manifoldId: 'MF-005',
      manifoldType: 'Type B',
      portCount: 12,
      location: 'Control Room A',
      lastCalibrationDate: '13/09/2022',
      history: [],
    ),
  ];

  /// Get filtered and paginated items
  List<MaintenanceManifold> getFilteredAndPaginatedItems() {
    List<MaintenanceManifold> filtered = allItems;

    // Apply search filter
    if (searchController.text.isNotEmpty) {
      final query = searchController.text.toLowerCase();
      filtered = filtered
          .where((item) =>
              item.id.toLowerCase().contains(query) ||
              item.manifoldId.toLowerCase().contains(query) ||
              item.manifoldType.toLowerCase().contains(query) ||
              item.location.toLowerCase().contains(query))
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
    List<MaintenanceManifold> filtered = allItems;

    if (searchController.text.isNotEmpty) {
      final query = searchController.text.toLowerCase();
      filtered = filtered
          .where((item) =>
              item.id.toLowerCase().contains(query) ||
              item.manifoldId.toLowerCase().contains(query) ||
              item.manifoldType.toLowerCase().contains(query) ||
              item.location.toLowerCase().contains(query))
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
                        'Manifold Maintenance',
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
                        searchHint: 'Search Manifold',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Manifold Maintenance List',
                        style: TextStyle(
                          color: const Color(0xFF101828),
                          fontSize: sw(20),
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w700,
                          height: 1.10,
                          letterSpacing: -0.40,
                        ),
                      ),
                      SizedBox(height: sh(20)),
                      if (items.isEmpty)
                        Column(
                          children: [
                            SizedBox(height: sh(50)),
                            Text(
                              'No items found',
                              style: TextStyle(
                                color: const Color(0xFF999999),
                                fontSize: sw(14),
                                fontFamily: 'Nunito Sans',
                              ),
                            ),
                          ],
                        )
                      else
                        Column(
                          children: items
                              .map((item) => MaintenanceListItemWidget(
                                    id: item.manifoldId,
                                    status: item.status,
                                    statusColor: item.statusColor,
                                    dateTime: item.dateTime,
                                    subtitle: '${item.manifoldType} (${item.portCount} ports) @ ${item.location}',
                                    onTap: () {
                                      context.push('/maintenance/manifold/${item.id}');
                                    },
                                  ))
                              .toList(),
                        ),
                    ],
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
