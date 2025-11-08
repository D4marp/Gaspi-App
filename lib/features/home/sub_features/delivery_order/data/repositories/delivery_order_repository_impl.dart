import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/delivery_order.dart';
import '../../domain/repositories/delivery_order_repository.dart';
import '../datasources/delivery_order_remote_datasource.dart';

/// Implementasi DeliveryOrderRepository
class DeliveryOrderRepositoryImpl implements DeliveryOrderRepository {
  final DeliveryOrderRemoteDataSource remoteDataSource;

  DeliveryOrderRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<DeliveryOrder>> getDeliveryOrders({
    int page = 1,
    int limit = 20,
    String? status,
    String? search,
  }) async {
    final models = await remoteDataSource.getDeliveryOrders(
      page: page,
      limit: limit,
      status: status,
      search: search,
    );

    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<DeliveryOrder> getDeliveryOrderById(String id) async {
    final model = await remoteDataSource.getDeliveryOrderById(id);
    return model.toEntity();
  }

  @override
  Future<DeliveryOrder> updateStatus(String id, String status) async {
    final model = await remoteDataSource.updateStatus(id, status);
    return model.toEntity();
  }

  @override
  Future<DeliveryOrder> confirmDelivery(
    String id, {
    required String signature,
    String? notes,
  }) async {
    final model = await remoteDataSource.confirmDelivery(
      id,
      signature: signature,
      notes: notes,
    );
    return model.toEntity();
  }
}

/// Provider untuk DeliveryOrderRepository
final deliveryOrderRepositoryProvider = Provider<DeliveryOrderRepository>((ref) {
  final remoteDataSource = ref.watch(deliveryOrderRemoteDataSourceProvider);
  return DeliveryOrderRepositoryImpl(remoteDataSource);
});
