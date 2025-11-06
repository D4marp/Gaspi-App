import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/maintenance_repository_impl.dart';
import '../../domain/entities/maintenance.dart';

part 'maintenance_provider.g.dart';

/// Provider untuk list maintenance
@riverpod
class MaintenanceList extends _$MaintenanceList {
  @override
  Future<List<Maintenance>> build() async {
    final repository = ref.read(maintenanceRepositoryProvider);
    return await repository.getMaintenanceList();
  }

  /// Refresh data
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(maintenanceRepositoryProvider);
      return await repository.getMaintenanceList();
    });
  }

  /// Complete maintenance
  Future<void> complete(String id, String notes) async {
    try {
      final repository = ref.read(maintenanceRepositoryProvider);
      await repository.completeMaintenance(id, notes: notes);
      
      // Refresh list
      await refresh();
    } catch (e) {
      rethrow;
    }
  }
}
