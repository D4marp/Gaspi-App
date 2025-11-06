import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/delivery_order.dart';

/// Mock Data Provider untuk Development/Slicing UI
/// Tidak perlu API, langsung return dummy data
final deliveryOrderListProvider = Provider<List<DeliveryOrder>>((ref) {
  return _mockDeliveryOrders;
});

/// Mock data untuk testing UI
final List<DeliveryOrder> _mockDeliveryOrders = [
  DeliveryOrder(
    id: '1',
    doNumber: 'DO-2024-001',
    customerName: 'PT. Maju Jaya',
    customerAddress: 'Jl. Sudirman No. 123, Jakarta Pusat',
    deliveryDate: DateTime.now().add(const Duration(days: 1)),
    status: 'pending',
    items: const [
      DeliveryItem(
        id: '1',
        productName: 'Tabung LPG 3kg',
        productCode: 'LPG-3KG',
        quantity: 50,
        unit: 'pcs',
        price: 15000,
      ),
      DeliveryItem(
        id: '2',
        productName: 'Tabung LPG 12kg',
        productCode: 'LPG-12KG',
        quantity: 30,
        unit: 'pcs',
        price: 85000,
      ),
    ],
    driverName: 'Budi Santoso',
    vehicleNumber: 'B 1234 XYZ',
    notes: 'Pengiriman pagi hari',
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    updatedAt: DateTime.now(),
  ),
  DeliveryOrder(
    id: '2',
    doNumber: 'DO-2024-002',
    customerName: 'CV. Berkah Sentosa',
    customerAddress: 'Jl. Gatot Subroto No. 45, Jakarta Selatan',
    deliveryDate: DateTime.now(),
    status: 'on_delivery',
    items: const [
      DeliveryItem(
        id: '3',
        productName: 'Tabung LPG 5.5kg',
        productCode: 'LPG-5.5KG',
        quantity: 100,
        unit: 'pcs',
        price: 35000,
      ),
    ],
    driverName: 'Ahmad Hidayat',
    vehicleNumber: 'B 5678 ABC',
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    updatedAt: DateTime.now(),
  ),
  DeliveryOrder(
    id: '3',
    doNumber: 'DO-2024-003',
    customerName: 'Toko Sumber Rejeki',
    customerAddress: 'Jl. Raya Bogor No. 88, Jakarta Timur',
    deliveryDate: DateTime.now().subtract(const Duration(days: 1)),
    status: 'completed',
    items: const [
      DeliveryItem(
        id: '4',
        productName: 'Tabung LPG 12kg',
        productCode: 'LPG-12KG',
        quantity: 20,
        unit: 'pcs',
        price: 85000,
      ),
      DeliveryItem(
        id: '5',
        productName: 'Tabung LPG 3kg',
        productCode: 'LPG-3KG',
        quantity: 40,
        unit: 'pcs',
        price: 15000,
      ),
    ],
    driverName: 'Slamet Riyadi',
    vehicleNumber: 'B 9012 DEF',
    notes: 'Sudah diterima pelanggan dengan baik',
    createdAt: DateTime.now().subtract(const Duration(days: 3)),
    updatedAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
  DeliveryOrder(
    id: '4',
    doNumber: 'DO-2024-004',
    customerName: 'UD. Sari Makmur',
    customerAddress: 'Jl. Kemang Raya No. 67, Jakarta Selatan',
    deliveryDate: DateTime.now().add(const Duration(days: 2)),
    status: 'pending',
    items: const [
      DeliveryItem(
        id: '6',
        productName: 'Tabung LPG 3kg',
        productCode: 'LPG-3KG',
        quantity: 80,
        unit: 'pcs',
        price: 15000,
      ),
    ],
    driverName: null,
    vehicleNumber: null,
    notes: 'Menunggu konfirmasi driver',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  DeliveryOrder(
    id: '5',
    doNumber: 'DO-2024-005',
    customerName: 'PT. Sejahtera Abadi',
    customerAddress: 'Jl. HR Rasuna Said No. 10, Jakarta Pusat',
    deliveryDate: DateTime.now().add(const Duration(hours: 3)),
    status: 'on_delivery',
    items: const [
      DeliveryItem(
        id: '7',
        productName: 'Tabung LPG 12kg',
        productCode: 'LPG-12KG',
        quantity: 150,
        unit: 'pcs',
        price: 85000,
      ),
      DeliveryItem(
        id: '8',
        productName: 'Tabung LPG 5.5kg',
        productCode: 'LPG-5.5KG',
        quantity: 80,
        unit: 'pcs',
        price: 35000,
      ),
    ],
    driverName: 'Joko Susilo',
    vehicleNumber: 'B 3456 GHI',
    notes: 'Pengiriman besar, butuh 2 truk',
    createdAt: DateTime.now().subtract(const Duration(hours: 6)),
    updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
  ),
];

/// Provider untuk filter berdasarkan status
final filteredDeliveryOrderProvider = Provider.family<List<DeliveryOrder>, String?>((ref, status) {
  final allOrders = ref.watch(deliveryOrderListProvider);
  
  if (status == null || status.isEmpty) {
    return allOrders;
  }
  
  return allOrders.where((order) => order.status == status).toList();
});

/// Provider untuk search
final searchedDeliveryOrderProvider = Provider.family<List<DeliveryOrder>, String?>((ref, query) {
  final allOrders = ref.watch(deliveryOrderListProvider);
  
  if (query == null || query.isEmpty) {
    return allOrders;
  }
  
  final lowerQuery = query.toLowerCase();
  return allOrders.where((order) {
    return order.doNumber.toLowerCase().contains(lowerQuery) ||
           order.customerName.toLowerCase().contains(lowerQuery) ||
           order.customerAddress.toLowerCase().contains(lowerQuery);
  }).toList();
});

/// Provider untuk detail delivery order
final deliveryOrderDetailProvider = Provider.family<DeliveryOrder?, String>((ref, id) {
  final allOrders = ref.watch(deliveryOrderListProvider);
  try {
    return allOrders.firstWhere((order) => order.id == id);
  } catch (e) {
    return null;
  }
});
