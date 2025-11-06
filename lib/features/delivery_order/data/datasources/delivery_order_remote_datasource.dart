import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_service.dart';
import '../models/delivery_order_model.dart';

/// Remote Data Source untuk Delivery Order
class DeliveryOrderRemoteDataSource {
  final ApiService _apiService;

  DeliveryOrderRemoteDataSource(this._apiService);

  /// Get list delivery orders
  Future<List<DeliveryOrderModel>> getDeliveryOrders({
    int page = 1,
    int limit = 20,
    String? status,
    String? search,
  }) async {
    final response = await _apiService.get(
      ApiEndpoints.deliveryOrders,
      queryParameters: {
        'page': page,
        'limit': limit,
        if (status != null) 'status': status,
        if (search != null) 'search': search,
      },
    );

    final List<dynamic> data = response.data['data'];
    return data.map((json) => DeliveryOrderModel.fromJson(json)).toList();
  }

  /// Get delivery order by ID
  Future<DeliveryOrderModel> getDeliveryOrderById(String id) async {
    final response = await _apiService.get(
      ApiEndpoints.deliveryOrderDetail(id),
    );

    return DeliveryOrderModel.fromJson(response.data['data']);
  }

  /// Update status
  Future<DeliveryOrderModel> updateStatus(String id, String status) async {
    final response = await _apiService.patch(
      ApiEndpoints.deliveryOrderUpdateStatus(id),
      data: {'status': status},
    );

    return DeliveryOrderModel.fromJson(response.data['data']);
  }

  /// Confirm delivery
  Future<DeliveryOrderModel> confirmDelivery(
    String id, {
    required String signature,
    String? notes,
  }) async {
    final response = await _apiService.post(
      ApiEndpoints.deliveryOrderConfirm(id),
      data: {
        'signature': signature,
        if (notes != null) 'notes': notes,
      },
    );

    return DeliveryOrderModel.fromJson(response.data['data']);
  }
}

/// Provider untuk DeliveryOrderRemoteDataSource
final deliveryOrderRemoteDataSourceProvider =
    Provider<DeliveryOrderRemoteDataSource>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return DeliveryOrderRemoteDataSource(apiService);
});
