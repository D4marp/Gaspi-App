class ActivityLog {
  final String id;
  final String action;
  final String userName;
  final String dateTime;
  final String timestamp; // For sorting

  ActivityLog({
    required this.id,
    required this.action,
    required this.userName,
    required this.dateTime,
    required this.timestamp,
  });

  factory ActivityLog.fromJson(Map<String, dynamic> json) {
    return ActivityLog(
      id: json['id'] as String? ?? '',
      action: json['action'] as String? ?? '',
      userName: json['userName'] as String? ?? '',
      dateTime: json['dateTime'] as String? ?? '',
      timestamp: json['timestamp'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'action': action,
      'userName': userName,
      'dateTime': dateTime,
      'timestamp': timestamp,
    };
  }
}
