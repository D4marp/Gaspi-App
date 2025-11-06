import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/delivery_order_repository_impl.dart';
import '../../domain/entities/delivery_order.dart';

part 'do_provider.g.dart';

/// Provider untuk list delivery orders dengan filter
@riverpod
class DeliveryOrderList extends _$DeliveryOrderList {
  String? _currentStatus;
  String? _currentSearch;

  @override
  Future<List<DeliveryOrder>> build() async {
    return _fetchDeliveryOrders();
  }

  Future<List<DeliveryOrder>> _fetchDeliveryOrders() async {
    final repository = ref.read(deliveryOrderRepositoryProvider);
    return await repository.getDeliveryOrders(
      status: _currentStatus,
      search: _currentSearch,
    );
  }

  /// Refresh data
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchDeliveryOrders());
  }

  /// Filter by status
  Future<void> filterByStatus(String? status) async {
    _currentStatus = status;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchDeliveryOrders());
  }

  /// Search
  Future<void> search(String? query) async {
    _currentSearch = query;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchDeliveryOrders());
  }
}

/// Provider untuk detail delivery order
@riverpod
Future<DeliveryOrder> deliveryOrderDetail(
  Ref ref,
  String id,
) async {
  final repository = ref.read(deliveryOrderRepositoryProvider);
  return await repository.getDeliveryOrderById(id);
}

/// Provider untuk update status
@riverpod
class DeliveryOrderStatusUpdater extends _$DeliveryOrderStatusUpdater {
  @override
  FutureOr<void> build() {}

  Future<void> updateStatus(String id, String status) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(deliveryOrderRepositoryProvider);
      await repository.updateStatus(id, status);

      // Refresh list setelah update
      ref.invalidate(deliveryOrderListProvider);
    });
  }

  Future<void> confirmDelivery(
    String id, {
    required String signature,
    String? notes,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final repository = ref.read(deliveryOrderRepositoryProvider);
      await repository.confirmDelivery(
        id,
        signature: signature,
        notes: notes,
      );

      // Refresh list setelah confirm
      ref.invalidate(deliveryOrderListProvider);
    });
  }
}
