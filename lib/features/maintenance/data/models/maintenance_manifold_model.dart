import 'package:flutter/material.dart';
import 'maintenance_base_model.dart';

/// Maintenance model for Manifold type
class MaintenanceManifold extends MaintenanceBaseModel {
  final String manifoldId; // Unique manifold identifier
  final String manifoldType; // e.g., 'Type A', 'Type B'
  final int portCount; // Number of ports
  final String location; // Current location
  final String lastCalibrationDate;
  final List<MaintenanceManifoldHistory> history;

  MaintenanceManifold({
    required String id,
    required String status,
    required Color statusColor,
    required String dateTime,
    required this.manifoldId,
    required this.manifoldType,
    required this.portCount,
    required this.location,
    required this.lastCalibrationDate,
    required this.history,
    String? remark,
  }) : super(
    id: id,
    status: status,
    statusColor: statusColor,
    dateTime: dateTime,
    remark: remark,
  );

  /// Create from JSON for API integration
  factory MaintenanceManifold.fromJson(Map<String, dynamic> json) {
    return MaintenanceManifold(
      id: json['id'] ?? '',
      status: json['status'] ?? 'Pending',
      statusColor: _getStatusColor(json['status'] ?? 'Pending'),
      dateTime: json['dateTime'] ?? '',
      manifoldId: json['manifoldId'] ?? '',
      manifoldType: json['manifoldType'] ?? '',
      portCount: json['portCount'] ?? 0,
      location: json['location'] ?? '',
      lastCalibrationDate: json['lastCalibrationDate'] ?? '',
      history: (json['history'] as List?)
          ?.map((h) => MaintenanceManifoldHistory.fromJson(h))
          .toList() ?? [],
      remark: json['remark'],
    );
  }

  /// Convert to JSON for API submission
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'dateTime': dateTime,
      'manifoldId': manifoldId,
      'manifoldType': manifoldType,
      'portCount': portCount,
      'location': location,
      'lastCalibrationDate': lastCalibrationDate,
      'history': history.map((h) => h.toJson()).toList(),
      'remark': remark,
    };
  }

  static Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color(0xFFF1003C);
      case 'on process':
        return const Color(0xFFFF7F00);
      case 'completed':
        return const Color(0xFF00B857);
      default:
        return const Color(0xFF999999);
    }
  }
}

/// History entry for manifold maintenance
class MaintenanceManifoldHistory {
  final int entryNo;
  final String maintenanceType;
  final String maintenanceDate;
  final String technician;

  MaintenanceManifoldHistory({
    required this.entryNo,
    required this.maintenanceType,
    required this.maintenanceDate,
    required this.technician,
  });

  factory MaintenanceManifoldHistory.fromJson(Map<String, dynamic> json) {
    return MaintenanceManifoldHistory(
      entryNo: json['entryNo'] ?? 0,
      maintenanceType: json['maintenanceType'] ?? '',
      maintenanceDate: json['maintenanceDate'] ?? '',
      technician: json['technician'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'entryNo': entryNo,
      'maintenanceType': maintenanceType,
      'maintenanceDate': maintenanceDate,
      'technician': technician,
    };
  }
}
