import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/maintenance.dart';
import '../../domain/repositories/maintenance_repository.dart';

/// Dummy implementation untuk Maintenance Repository
class MaintenanceRepositoryImpl implements MaintenanceRepository {
  @override
  Future<List<Maintenance>> getMaintenanceList({
    int page = 1,
    int limit = 20,
    String? status,
  }) async {
    // TODO: Implement API call
    // Untuk saat ini return dummy data
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }

  @override
  Future<Maintenance> getMaintenanceById(String id) async {
    // TODO: Implement API call
    throw UnimplementedError();
  }

  @override
  Future<Maintenance> completeMaintenance(String id, {required String notes}) async {
    // TODO: Implement API call
    throw UnimplementedError();
  }
}

/// Provider untuk MaintenanceRepository
final maintenanceRepositoryProvider = Provider<MaintenanceRepository>((ref) {
  return MaintenanceRepositoryImpl();
});
