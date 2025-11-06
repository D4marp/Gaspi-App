/// Konstanta global aplikasi Gaspi Mobile App
class AppConstants {
  // App Info
  static const String appName = 'Gaspi Mobile';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String baseUrl = 'https://api.gaspi.com/v1'; // Ganti dengan URL API Anda
  static const int connectTimeout = 30000; // 30 detik
  static const int receiveTimeout = 30000;
  
  // Storage Keys
  static const String keyToken = 'auth_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keyUserRole = 'user_role';
  static const String keyUserData = 'user_data';
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Date Format
  static const String dateFormat = 'dd/MM/yyyy';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';
  static const String timeFormat = 'HH:mm';
  
  // Asset Paths
  static const String imagePath = 'assets/images';
  static const String iconPath = 'assets/icons';
  static const String logoPath = '$imagePath/logo.png';
}
