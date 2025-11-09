import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/dialog_helper.dart';
import '../../../home/presentation/widgets/navigation_wrapper.dart';
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

    return NavigationWrapper(
      title: 'Delivery Order',
      child: Column(
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
                          color: AppTheme.textHintColor,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Tidak ada delivery order',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppTheme.textSecondaryColor,
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
      selectedColor: const Color(0xFF007EFF).withOpacity(0.2),
      checkmarkColor: const Color(0xFF007EFF),
      labelStyle: TextStyle(
        color: isSelected ? const Color(0xFF007EFF) : Colors.grey[600],
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
        return AppTheme.warningColor;
      case 'on_delivery':
        return AppTheme.infoColor;
      case 'completed':
        return AppTheme.successColor;
      case 'cancelled':
        return AppTheme.errorColor;
      default:
        return AppTheme.textSecondaryColor;
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
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                  Icon(Icons.person_outline, size: 16, color: AppTheme.textSecondaryColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      deliveryOrder.customerName,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              Row(
                children: [
                  Icon(Icons.location_on_outlined,
                      size: 16, color: AppTheme.textSecondaryColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      deliveryOrder.customerAddress,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondaryColor,
                      ),
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
                  Icon(Icons.calendar_today_outlined,
                      size: 16, color: AppTheme.textSecondaryColor),
                  const SizedBox(width: 8),
                  Text(
                    DateFormatter.formatDate(deliveryOrder.deliveryDate),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Items Count
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${deliveryOrder.items.length} Item',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
