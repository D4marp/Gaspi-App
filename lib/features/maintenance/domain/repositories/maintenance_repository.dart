import '../entities/maintenance.dart';

/// Repository interface untuk Maintenance
abstract class MaintenanceRepository {
  /// Get list maintenance
  Future<List<Maintenance>> getMaintenanceList({
    int page = 1,
    int limit = 20,
    String? status,
  });

  /// Get maintenance detail
  Future<Maintenance> getMaintenanceById(String id);

  /// Complete maintenance
  Future<Maintenance> completeMaintenance(
    String id, {
    required String notes,
  });
}
