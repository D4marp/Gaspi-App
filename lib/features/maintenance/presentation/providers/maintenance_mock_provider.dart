import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/maintenance.dart';

/// Mock Data Provider untuk Development/Slicing UI
/// Tidak perlu API, langsung return dummy data
final maintenanceListProvider = Provider<List<Maintenance>>((ref) {
  return _mockMaintenanceList;
});

/// Mock data untuk testing UI
final List<Maintenance> _mockMaintenanceList = [
  Maintenance(
    id: '1',
    assetId: 'AST-001',
    assetName: 'Forklift Toyota FD25',
    maintenanceType: 'preventive',
    scheduledDate: DateTime.now().add(const Duration(days: 2)),
    status: 'scheduled',
    tasks: const [
      MaintenanceTask(
        id: '1',
        description: 'Pengecekan oli mesin',
        isCompleted: false,
      ),
      MaintenanceTask(
        id: '2',
        description: 'Pengecekan sistem hidrolik',
        isCompleted: false,
      ),
      MaintenanceTask(
        id: '3',
        description: 'Pengecekan ban dan roda',
        isCompleted: false,
      ),
    ],
    technician: 'John Doe',
    notes: 'Service rutin bulanan forklift',
  ),
  Maintenance(
    id: '2',
    assetId: 'AST-002',
    assetName: 'Truk Tangki Pertamina',
    maintenanceType: 'corrective',
    scheduledDate: DateTime.now(),
    status: 'in_progress',
    tasks: const [
      MaintenanceTask(
        id: '4',
        description: 'Identifikasi lokasi kebocoran',
        isCompleted: true,
      ),
      MaintenanceTask(
        id: '5',
        description: 'Las bagian yang bocor',
        isCompleted: true,
      ),
      MaintenanceTask(
        id: '6',
        description: 'Test kebocoran dengan air',
        isCompleted: false,
      ),
      MaintenanceTask(
        id: '7',
        description: 'Pengecatan ulang',
        isCompleted: false,
      ),
    ],
    technician: 'Ahmad Santoso',
    completedDate: null,
    notes: 'Perbaikan kebocoran tangki - Kebocoran ditemukan di bagian bawah tangki',
  ),
  Maintenance(
    id: '3',
    assetId: 'AST-003',
    assetName: 'Kompresor Udara Atlas Copco',
    maintenanceType: 'preventive',
    scheduledDate: DateTime.now().subtract(const Duration(days: 3)),
    status: 'completed',
    tasks: const [
      MaintenanceTask(
        id: '8',
        description: 'Ganti filter udara',
        isCompleted: true,
      ),
      MaintenanceTask(
        id: '9',
        description: 'Ganti oli kompresor',
        isCompleted: true,
      ),
      MaintenanceTask(
        id: '10',
        description: 'Pembersihan radiator',
        isCompleted: true,
      ),
    ],
    technician: 'Budi Hartono',
    completedDate: DateTime.now().subtract(const Duration(days: 2)),
    notes: 'Penggantian filter udara dan oli - Maintenance selesai tepat waktu, semua parts diganti',
  ),
  Maintenance(
    id: '4',
    assetId: 'AST-004',
    assetName: 'Mesin Filling LPG Otomatis',
    maintenanceType: 'preventive',
    scheduledDate: DateTime.now().add(const Duration(days: 7)),
    status: 'scheduled',
    tasks: const [
      MaintenanceTask(
        id: '11',
        description: 'Kalibrasi sensor berat',
        isCompleted: false,
      ),
      MaintenanceTask(
        id: '12',
        description: 'Test sistem emergency stop',
        isCompleted: false,
      ),
      MaintenanceTask(
        id: '13',
        description: 'Pengecekan valve pengaman',
        isCompleted: false,
      ),
      MaintenanceTask(
        id: '14',
        description: 'Pembersihan nozzle filling',
        isCompleted: false,
      ),
    ],
    technician: null,
    notes: 'Kalibrasi sensor dan pengecekan sistem keamanan',
  ),
  Maintenance(
    id: '5',
    assetId: 'AST-005',
    assetName: 'Genset Perkins 150 kVA',
    maintenanceType: 'corrective',
    scheduledDate: DateTime.now().add(const Duration(hours: 5)),
    status: 'scheduled',
    tasks: const [
      MaintenanceTask(
        id: '15',
        description: 'Pemeriksaan aki',
        isCompleted: false,
      ),
      MaintenanceTask(
        id: '16',
        description: 'Pengecekan motor starter',
        isCompleted: false,
      ),
      MaintenanceTask(
        id: '17',
        description: 'Pengecekan relay dan kabel',
        isCompleted: false,
      ),
    ],
    technician: 'Slamet Riyadi',
    notes: 'Perbaikan sistem starter yang tidak berfungsi - Urgent: Genset backup untuk produksi',
  ),
];

/// Provider untuk filter berdasarkan status
final filteredMaintenanceProvider =
    Provider.family<List<Maintenance>, String?>((ref, status) {
  final allMaintenance = ref.watch(maintenanceListProvider);

  if (status == null || status.isEmpty) {
    return allMaintenance;
  }

  return allMaintenance.where((m) => m.status == status).toList();
});

/// Provider untuk filter berdasarkan maintenance type
final maintenanceByTypeProvider =
    Provider.family<List<Maintenance>, String?>((ref, type) {
  final allMaintenance = ref.watch(maintenanceListProvider);

  if (type == null || type.isEmpty) {
    return allMaintenance;
  }

  return allMaintenance.where((m) => m.maintenanceType == type).toList();
});

/// Provider untuk detail maintenance
final maintenanceDetailProvider =
    Provider.family<Maintenance?, String>((ref, id) {
  final allMaintenance = ref.watch(maintenanceListProvider);
  try {
    return allMaintenance.firstWhere((m) => m.id == id);
  } catch (e) {
    return null;
  }
});
