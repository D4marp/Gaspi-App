import 'package:equatable/equatable.dart';

/// Entity untuk Maintenance/RBA
class Maintenance extends Equatable {
  final String id;
  final String assetId;
  final String assetName;
  final String maintenanceType; // preventive, corrective
  final String status; // scheduled, in_progress, completed
  final DateTime scheduledDate;
  final DateTime? completedDate;
  final String? technician;
  final String? notes;
  final List<MaintenanceTask> tasks;

  const Maintenance({
    required this.id,
    required this.assetId,
    required this.assetName,
    required this.maintenanceType,
    required this.status,
    required this.scheduledDate,
    this.completedDate,
    this.technician,
    this.notes,
    required this.tasks,
  });

  @override
  List<Object?> get props => [
        id,
        assetId,
        assetName,
        maintenanceType,
        status,
        scheduledDate,
        completedDate,
        technician,
        notes,
        tasks,
      ];
}

class MaintenanceTask extends Equatable {
  final String id;
  final String description;
  final bool isCompleted;

  const MaintenanceTask({
    required this.id,
    required this.description,
    required this.isCompleted,
  });

  @override
  List<Object> get props => [id, description, isCompleted];
}
