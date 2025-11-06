import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/dialog_helper.dart';
import '../../domain/entities/delivery_order.dart';
import '../providers/do_mock_provider.dart'; // Using mock data for UI slicing

/// Halaman Delivery Order List
class DeliveryOrderPage extends ConsumerStatefulWidget {
  const DeliveryOrderPage({super.key});

  @override
  ConsumerState<DeliveryOrderPage> createState() => _DeliveryOrderPageState();
}

class _DeliveryOrderPageState extends ConsumerState<DeliveryOrderPage> {
  String? _selectedStatus;
  String? _searchQuery;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<DeliveryOrder> _getFilteredOrders() {
    var orders = ref.watch(deliveryOrderListProvider);
    
    // Filter by status
    if (_selectedStatus != null && _selectedStatus!.isNotEmpty) {
      orders = orders.where((order) => order.status == _selectedStatus).toList();
    }
    
    // Filter by search
    if (_searchQuery != null && _searchQuery!.isNotEmpty) {
      final lowerQuery = _searchQuery!.toLowerCase();
      orders = orders.where((order) {
        return order.doNumber.toLowerCase().contains(lowerQuery) ||
               order.customerName.toLowerCase().contains(lowerQuery);
      }).toList();
    }
    
    return orders;
  }

  @override
  Widget build(BuildContext context) {
    final deliveryOrders = _getFilteredOrders();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Order'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Show filter options
              SnackBarHelper.showInfo(context, 'Filter options coming soon');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter & Search
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              children: [
                // Search
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari DO Number atau Customer...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                _searchQuery = null;
                              });
                            },
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value.isEmpty ? null : value;
                    });
                  },
                ),
                const SizedBox(height: 12),

                // Status Filter
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterChip('Semua', null),
                      const SizedBox(width: 8),
                      _buildFilterChip('Menunggu', 'pending'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Dalam Pengiriman', 'on_delivery'),
                      const SizedBox(width: 8),
                      _buildFilterChip('Selesai', 'completed'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // List
          Expanded(
            child: deliveryOrders.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Tidak ada delivery order',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      setState(() {}); // Trigger rebuild
                      SnackBarHelper.showSuccess(context, 'Data di-refresh');
                    },
                    child: ListView.builder(
                      itemCount: deliveryOrders.length,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemBuilder: (context, index) {
                        final deliveryOrder = deliveryOrders[index];
                        return _DeliveryOrderCard(deliveryOrder: deliveryOrder);
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String? status) {
    final isSelected = _selectedStatus == status;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedStatus = selected ? status : null;
        });
      },
      backgroundColor: Colors.grey[200],
      selectedColor: AppTheme.primaryColor.withOpacity(0.2),
      checkmarkColor: AppTheme.primaryColor,
      labelStyle: TextStyle(
        color: isSelected ? AppTheme.primaryColor : Colors.grey[700],
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }
}

/// Card untuk menampilkan delivery order item
class _DeliveryOrderCard extends StatelessWidget {
  final DeliveryOrder deliveryOrder;

  const _DeliveryOrderCard({required this.deliveryOrder});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'on_delivery':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to detail page
          SnackBarHelper.showInfo(
            context,
            'Detail DO: ${deliveryOrder.doNumber}',
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      deliveryOrder.doNumber,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(deliveryOrder.status)
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      deliveryOrder.statusDisplay,
                      style: TextStyle(
                        color: _getStatusColor(deliveryOrder.status),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Customer Info
              Row(
                children: [
                  const Icon(Icons.person_outline, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      deliveryOrder.customerName,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              Row(
                children: [
                  const Icon(Icons.location_on_outlined,
                      size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      deliveryOrder.customerAddress,
                      style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              // Delivery Date
              Row(
                children: [
                  const Icon(Icons.calendar_today_outlined,
                      size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(
                    DateFormatter.formatDate(deliveryOrder.deliveryDate),
                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Items Count
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${deliveryOrder.items.length} Item',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
