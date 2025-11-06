import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/delivery_order.dart';

part 'delivery_order_model.g.dart';

/// Model Delivery Order untuk data layer
@JsonSerializable()
class DeliveryOrderModel {
  final String id;
  @JsonKey(name: 'do_number')
  final String doNumber;
  @JsonKey(name: 'customer_name')
  final String customerName;
  @JsonKey(name: 'customer_address')
  final String customerAddress;
  @JsonKey(name: 'delivery_date')
  final String deliveryDate;
  final String status;
  final List<DeliveryItemModel> items;
  final String? notes;
  @JsonKey(name: 'driver_name')
  final String? driverName;
  @JsonKey(name: 'vehicle_number')
  final String? vehicleNumber;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;

  DeliveryOrderModel({
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

  factory DeliveryOrderModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryOrderModelToJson(this);

  /// Convert ke entity
  DeliveryOrder toEntity() {
    return DeliveryOrder(
      id: id,
      doNumber: doNumber,
      customerName: customerName,
      customerAddress: customerAddress,
      deliveryDate: DateTime.parse(deliveryDate),
      status: status,
      items: items.map((item) => item.toEntity()).toList(),
      notes: notes,
      driverName: driverName,
      vehicleNumber: vehicleNumber,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
    );
  }
}

/// Model untuk Delivery Item
@JsonSerializable()
class DeliveryItemModel {
  final String id;
  @JsonKey(name: 'product_name')
  final String productName;
  @JsonKey(name: 'product_code')
  final String productCode;
  final int quantity;
  final String unit;
  final double? price;

  DeliveryItemModel({
    required this.id,
    required this.productName,
    required this.productCode,
    required this.quantity,
    required this.unit,
    this.price,
  });

  factory DeliveryItemModel.fromJson(Map<String, dynamic> json) =>
      _$DeliveryItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeliveryItemModelToJson(this);

  /// Convert ke entity
  DeliveryItem toEntity() {
    return DeliveryItem(
      id: id,
      productName: productName,
      productCode: productCode,
      quantity: quantity,
      unit: unit,
      price: price,
    );
  }
}
