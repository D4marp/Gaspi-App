import '../entities/delivery_order.dart';

/// Repository interface untuk Delivery Order
abstract class DeliveryOrderRepository {
  /// Get list delivery orders dengan pagination dan filter
  Future<List<DeliveryOrder>> getDeliveryOrders({
    int page = 1,
    int limit = 20,
    String? status,
    String? search,
  });

  /// Get detail delivery order by ID
  Future<DeliveryOrder> getDeliveryOrderById(String id);

  /// Update status delivery order
  Future<DeliveryOrder> updateStatus(String id, String status);

  /// Confirm delivery order
  Future<DeliveryOrder> confirmDelivery(
    String id, {
    required String signature,
    String? notes,
  });
}
