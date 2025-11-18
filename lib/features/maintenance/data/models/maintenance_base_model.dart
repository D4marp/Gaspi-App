import 'package:flutter/material.dart';

/// Base model for all maintenance types
abstract class MaintenanceBaseModel {
  final String id;
  final String status; // 'Pending', 'On Process', 'Completed'
  final Color statusColor;
  final String dateTime;
  final String? remark;

  MaintenanceBaseModel({
    required this.id,
    required this.status,
    required this.statusColor,
    required this.dateTime,
    this.remark,
  });
}
