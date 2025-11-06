/// Endpoint API untuk semua fitur aplikasi
class ApiEndpoints {
  // Base
  static const String api = '/api';
  
  // Authentication
  static const String login = '$api/auth/login';
  static const String logout = '$api/auth/logout';
  static const String refreshToken = '$api/auth/refresh';
  static const String profile = '$api/auth/profile';
  
  // Delivery Order (DO)
  static const String deliveryOrders = '$api/delivery-orders';
  static String deliveryOrderDetail(String id) => '$deliveryOrders/$id';
  static String deliveryOrderUpdateStatus(String id) => '$deliveryOrders/$id/status';
  static String deliveryOrderConfirm(String id) => '$deliveryOrders/$id/confirm';
  
  // Empty Cylinder Return (ECR)
  static const String emptyReturns = '$api/empty-returns';
  static String emptyReturnDetail(String id) => '$emptyReturns/$id';
  static String emptyReturnVerify(String id) => '$emptyReturns/$id/verify';
  
  // Inventory Management
  static const String inventory = '$api/inventory';
  static const String inventoryStock = '$inventory/stock';
  static const String inventoryMovement = '$inventory/movement';
  static String inventoryDetail(String id) => '$inventory/$id';
  
  // Asset Tracking
  static const String assets = '$api/assets';
  static String assetDetail(String id) => '$assets/$id';
  static String assetHistory(String id) => '$assets/$id/history';
  static const String assetCategories = '$assets/categories';
  
  // Maintenance (RBA)
  static const String maintenance = '$api/maintenance';
  static String maintenanceDetail(String id) => '$maintenance/$id';
  static String maintenanceComplete(String id) => '$maintenance/$id/complete';
  static const String maintenanceSchedule = '$maintenance/schedule';
  
  // Users & Roles
  static const String users = '$api/users';
  static String userDetail(String id) => '$users/$id';
  static const String roles = '$api/roles';
  
  // Dashboard & Reports
  static const String dashboard = '$api/dashboard';
  static const String reports = '$api/reports';
  static const String reportsDO = '$reports/delivery-orders';
  static const String reportsInventory = '$reports/inventory';
}
