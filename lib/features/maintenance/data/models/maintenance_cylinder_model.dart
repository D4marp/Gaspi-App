import 'package:flutter/material.dart';
import 'maintenance_base_model.dart';

/// Maintenance model for Cylinder type
class MaintenanceCylinder extends MaintenanceBaseModel {
  final String registeredFor; // Company name
  final String process; // e.g., 'Convert from Argon to Oxygen'
  final bool isConversion;
  final String convertTo; // e.g., 'Oxygen (O2)'
  final String hydroTestingDate;
  final List<MaintenanceHistory> history;

  MaintenanceCylinder({
    required String id,
    required String status,
    required Color statusColor,
    required String dateTime,
    required this.registeredFor,
    required this.process,
    required this.isConversion,
    required this.convertTo,
    required this.hydroTestingDate,
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
  factory MaintenanceCylinder.fromJson(Map<String, dynamic> json) {
    return MaintenanceCylinder(
      id: json['id'] ?? '',
      status: json['status'] ?? 'Pending',
      statusColor: _getStatusColor(json['status'] ?? 'Pending'),
      dateTime: json['dateTime'] ?? '',
      registeredFor: json['registeredFor'] ?? '',
      process: json['process'] ?? '',
      isConversion: json['isConversion'] ?? false,
      convertTo: json['convertTo'] ?? '',
      hydroTestingDate: json['hydroTestingDate'] ?? '',
      history: (json['history'] as List?)
          ?.map((h) => MaintenanceHistory.fromJson(h))
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
      'registeredFor': registeredFor,
      'process': process,
      'isConversion': isConversion,
      'convertTo': convertTo,
      'hydroTestingDate': hydroTestingDate,
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

/// History entry for maintenance actions
class MaintenanceHistory {
  final int entryNo;
  final String action;
  final String actionDate;

  MaintenanceHistory({
    required this.entryNo,
    required this.action,
    required this.actionDate,
  });

  factory MaintenanceHistory.fromJson(Map<String, dynamic> json) {
    return MaintenanceHistory(
      entryNo: json['entryNo'] ?? 0,
      action: json['action'] ?? '',
      actionDate: json['actionDate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'entryNo': entryNo,
      'action': action,
      'actionDate': actionDate,
    };
  }
}
