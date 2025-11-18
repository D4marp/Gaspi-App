import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gaspi_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:gaspi_app/features/home/presentation/widgets/role_based_bottom_navigation.dart';
import 'package:gaspi_app/features/maintenance/data/models/maintenance_transport_rack_model.dart';
import 'package:gaspi_app/features/maintenance/presentation/widgets/maintenance_list_item_widget.dart';
import 'package:gaspi_app/features/maintenance/presentation/widgets/maintenance_filter_bar_widget.dart';
import 'package:gaspi_app/features/maintenance/presentation/widgets/maintenance_pagination_widget.dart';

class MaintenanceTransportRackPage extends ConsumerStatefulWidget {
  const MaintenanceTransportRackPage({super.key});

  @override
  ConsumerState<MaintenanceTransportRackPage> createState() => _MaintenanceTransportRackPageState();
}

class _MaintenanceTransportRackPageState extends ConsumerState<MaintenanceTransportRackPage> {
  int currentPage = 1;
  String? selectedFilter;
  final TextEditingController searchController = TextEditingController();
  final int itemsPerPage = 5;

  // Sample data - ready for API integration
  final List<MaintenanceTransportRack> allItems = [
    MaintenanceTransportRack(
      id: '251234',
      status: 'Pending',
      statusColor: const Color(0xFFF1003C),
      dateTime: '03:16 | 18 Sep 2022',
      rackId: 'TR-001',
      cylinderCount: 12,
      location: 'Warehouse A',
      lastInspectionDate: '15/09/2022',
      history: [
        MaintenanceRackHistory(
          entryNo: 1,
          inspectionType: 'Visual Check',
          inspectionDate: '15/09/2022',
          inspector: 'John Doe',
        ),
      ],
      remark: 'Initial inspection required',
    ),
    MaintenanceTransportRack(
      id: '251233',
      status: 'On Process',
      statusColor: const Color(0xFFFF7F00),
      dateTime: '02:45 | 17 Sep 2022',
      rackId: 'TR-002',
      cylinderCount: 10,
      location: 'Warehouse B',
      lastInspectionDate: '16/09/2022',
      history: [
        MaintenanceRackHistory(
          entryNo: 1,
          inspectionType: 'Structural Check',
          inspectionDate: '16/09/2022',
          inspector: 'Jane Smith',
        ),
      ],
    ),
    MaintenanceTransportRack(
      id: '251232',
      status: 'On Process',
      statusColor: const Color(0xFFFF7F00),
      dateTime: '01:30 | 17 Sep 2022',
      rackId: 'TR-003',
      cylinderCount: 15,
      location: 'Warehouse C',
      lastInspectionDate: '14/09/2022',
      history: [],
    ),
    MaintenanceTransportRack(
      id: '251231',
      status: 'On Process',
      statusColor: const Color(0xFFFF7F00),
      dateTime: '04:20 | 16 Sep 2022',
      rackId: 'TR-004',
      cylinderCount: 8,
      location: 'Warehouse A',
      lastInspectionDate: '18/09/2022',
      history: [],
    ),
    MaintenanceTransportRack(
      id: '251230',
      status: 'On Process',
      statusColor: const Color(0xFFFF7F00),
      dateTime: '05:10 | 16 Sep 2022',
      rackId: 'TR-005',
      cylinderCount: 12,
      location: 'Warehouse D',
      lastInspectionDate: '17/09/2022',
      history: [],
    ),
  ];

  /// Get filtered and paginated items
  List<MaintenanceTransportRack> getFilteredAndPaginatedItems() {
    List<MaintenanceTransportRack> filtered = allItems;

    // Apply search filter
    if (searchController.text.isNotEmpty) {
      final query = searchController.text.toLowerCase();
      filtered = filtered
          .where((item) =>
              item.id.toLowerCase().contains(query) ||
              item.rackId.toLowerCase().contains(query) ||
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
    List<MaintenanceTransportRack> filtered = allItems;

    if (searchController.text.isNotEmpty) {
      final query = searchController.text.toLowerCase();
      filtered = filtered
          .where((item) =>
              item.id.toLowerCase().contains(query) ||
              item.rackId.toLowerCase().contains(query) ||
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
                        'Transport Rack Maintenance',
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
                        searchHint: 'Search at Transport Rack',
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
                        'Transport Rack Maintenance List',
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
                                    id: item.rackId,
                                    status: item.status,
                                    statusColor: item.statusColor,
                                    dateTime: item.dateTime,
                                    subtitle: '${item.cylinderCount} Cylinders @ ${item.location}',
                                    onTap: () {
                                      context.push('/maintenance/transport-rack/${item.id}');
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
