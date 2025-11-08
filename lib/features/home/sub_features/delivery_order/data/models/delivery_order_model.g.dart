// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryOrderModel _$DeliveryOrderModelFromJson(Map<String, dynamic> json) =>
    DeliveryOrderModel(
      id: json['id'] as String,
      doNumber: json['do_number'] as String,
      customerName: json['customer_name'] as String,
      customerAddress: json['customer_address'] as String,
      deliveryDate: json['delivery_date'] as String,
      status: json['status'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => DeliveryItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      notes: json['notes'] as String?,
      driverName: json['driver_name'] as String?,
      vehicleNumber: json['vehicle_number'] as String?,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$DeliveryOrderModelToJson(DeliveryOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'do_number': instance.doNumber,
      'customer_name': instance.customerName,
      'customer_address': instance.customerAddress,
      'delivery_date': instance.deliveryDate,
      'status': instance.status,
      'items': instance.items,
      'notes': instance.notes,
      'driver_name': instance.driverName,
      'vehicle_number': instance.vehicleNumber,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

DeliveryItemModel _$DeliveryItemModelFromJson(Map<String, dynamic> json) =>
    DeliveryItemModel(
      id: json['id'] as String,
      productName: json['product_name'] as String,
      productCode: json['product_code'] as String,
      quantity: (json['quantity'] as num).toInt(),
      unit: json['unit'] as String,
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DeliveryItemModelToJson(DeliveryItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_name': instance.productName,
      'product_code': instance.productCode,
      'quantity': instance.quantity,
      'unit': instance.unit,
      'price': instance.price,
    };
