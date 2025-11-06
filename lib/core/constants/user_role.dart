/// Enum untuk Role-Based Access Control (RBAC)
/// Mendefinisikan 6 peran utama dalam sistem Gaspi
enum UserRole {
  superadmin('SUPERADMIN', 'Superadmin'),
  admin('ADMIN', 'Admin'),
  supervisor('SUPERVISOR', 'Supervisor'),
  coordinator('COORDINATOR', 'Coordinator'),
  production('PRODUCTION', 'Production'),
  maintenance('MAINTENANCE', 'Maintenance');

  final String value;
  final String displayName;

  const UserRole(this.value, this.displayName);

  /// Konversi dari string ke enum
  static UserRole fromString(String role) {
    return UserRole.values.firstWhere(
      (r) => r.value == role.toUpperCase(),
      orElse: () => UserRole.production,
    );
  }

  /// Cek apakah role memiliki akses admin
  bool get isAdmin => this == UserRole.superadmin || this == UserRole.admin;

  /// Cek apakah role memiliki akses supervisor
  bool get isSupervisor => this == UserRole.supervisor || isAdmin;

  /// Cek permission berdasarkan module
  bool hasPermission(String module, String action) {
    switch (this) {
      case UserRole.superadmin:
        return true; // Superadmin memiliki akses penuh

      case UserRole.admin:
        // Admin bisa akses semua kecuali sistem config
        return !module.contains('system');

      case UserRole.supervisor:
        // Supervisor bisa view & approve
        return ['view', 'approve', 'export'].contains(action);

      case UserRole.coordinator:
        // Coordinator bisa view, create, update
        return ['view', 'create', 'update'].contains(action);

      case UserRole.production:
        // Production fokus pada DO dan inventory
        return ['delivery_order', 'inventory'].contains(module) &&
            ['view', 'update'].contains(action);

      case UserRole.maintenance:
        // Maintenance fokus pada asset dan maintenance
        return ['asset', 'maintenance'].contains(module) &&
            ['view', 'create', 'update'].contains(action);
    }
  }
}
