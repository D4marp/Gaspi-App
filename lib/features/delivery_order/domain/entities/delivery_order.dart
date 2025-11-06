import 'package:equatable/equatable.dart';

/// Entity Delivery Order untuk domain layer
class DeliveryOrder extends Equatable {
  final String id;
  final String doNumber;
  final String customerName;
  final String customerAddress;
  final DateTime deliveryDate;
  final String status; // pending, on_delivery, completed, cancelled
  final List<DeliveryItem> items;
  final String? notes;
  final String? driverName;
  final String? vehicleNumber;
  final DateTime createdAt;
  final DateTime updatedAt;

  const DeliveryOrder({
    required this.id,
    required this.doNumber,
    required this.customerName,
    required this.customerAddress,
    required this.deliveryDate,
    required this.status,
    required this.items,
    this.notes,
    this.driverName,
    this.vehicleNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        doNumber,
        customerName,
        customerAddress,
        deliveryDate,
        status,
        items,
        notes,
        driverName,
        vehicleNumber,
        createdAt,
        updatedAt,
      ];

  /// Helper untuk status display
  String get statusDisplay {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Menunggu';
      case 'on_delivery':
        return 'Dalam Pengiriman';
      case 'completed':
        return 'Selesai';
      case 'cancelled':
        return 'Dibatalkan';
      default:
        return status;
    }
  }
}

/// Entity untuk item dalam delivery order
class DeliveryItem extends Equatable {
  final String id;
  final String productName;
  final String productCode;
  final int quantity;
  final String unit; // pcs, kg, liter
  final double? price;

  const DeliveryItem({
    required this.id,
    required this.productName,
    required this.productCode,
    required this.quantity,
    required this.unit,
    this.price,
  });

  @override
  List<Object?> get props => [
        id,
        productName,
        productCode,
        quantity,
        unit,
        price,
      ];
}
