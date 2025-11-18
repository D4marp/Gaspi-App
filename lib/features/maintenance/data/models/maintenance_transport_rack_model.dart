import 'package:flutter/material.dart';
import 'maintenance_base_model.dart';

/// Maintenance model for Transport Rack type
class MaintenanceTransportRack extends MaintenanceBaseModel {
  final String rackId; // Unique rack identifier
  final int cylinderCount; // Number of cylinders on rack
  final String location; // Current location
  final String lastInspectionDate;
  final List<MaintenanceRackHistory> history;

  MaintenanceTransportRack({
    required String id,
    required String status,
    required Color statusColor,
    required String dateTime,
    required this.rackId,
    required this.cylinderCount,
    required this.location,
    required this.lastInspectionDate,
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
  factory MaintenanceTransportRack.fromJson(Map<String, dynamic> json) {
    return MaintenanceTransportRack(
      id: json['id'] ?? '',
      status: json['status'] ?? 'Pending',
      statusColor: _getStatusColor(json['status'] ?? 'Pending'),
      dateTime: json['dateTime'] ?? '',
      rackId: json['rackId'] ?? '',
      cylinderCount: json['cylinderCount'] ?? 0,
      location: json['location'] ?? '',
      lastInspectionDate: json['lastInspectionDate'] ?? '',
      history: (json['history'] as List?)
          ?.map((h) => MaintenanceRackHistory.fromJson(h))
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
      'rackId': rackId,
      'cylinderCount': cylinderCount,
      'location': location,
      'lastInspectionDate': lastInspectionDate,
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

/// History entry for transport rack maintenance
class MaintenanceRackHistory {
  final int entryNo;
  final String inspectionType;
  final String inspectionDate;
  final String inspector;

  MaintenanceRackHistory({
    required this.entryNo,
    required this.inspectionType,
    required this.inspectionDate,
    required this.inspector,
  });

  factory MaintenanceRackHistory.fromJson(Map<String, dynamic> json) {
    return MaintenanceRackHistory(
      entryNo: json['entryNo'] ?? 0,
      inspectionType: json['inspectionType'] ?? '',
      inspectionDate: json['inspectionDate'] ?? '',
      inspector: json['inspector'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'entryNo': entryNo,
      'inspectionType': inspectionType,
      'inspectionDate': inspectionDate,
      'inspector': inspector,
    };
  }
}
