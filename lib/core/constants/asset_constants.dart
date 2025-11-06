/// Asset Constants
/// 
/// Central place untuk semua path assets yang digunakan di aplikasi
/// Gunakan constants ini untuk consistency dan type-safety
/// 
/// Usage:
/// ```dart
/// Image.asset(AssetConstants.logoPath)
/// SvgPicture.asset(AssetConstants.iconHome)
/// ```

class AssetConstants {
  AssetConstants._();

  // ========== LOGOS ==========
  /// Path untuk logo utama aplikasi
  static const String logoPath = 'assets/logos/app_logo.png';
  
  /// Path untuk logo putih (untuk dark background)
  static const String logoWhitePath = 'assets/logos/app_logo_white.png';
  
  /// Path untuk logo icon only (square)
  static const String logoIconPath = 'assets/logos/app_logo_icon.png';
  
  /// Path untuk logo company
  static const String companyLogoPath = 'assets/logos/company_logo.png';

  // ========== IMAGES ==========
  /// Background image untuk login page
  static const String loginBackgroundPath = 'assets/images/bg_login.png';
  
  /// Background image untuk home page
  static const String homeBackgroundPath = 'assets/images/bg_home.png';
  
  /// Placeholder image
  static const String placeholderPath = 'assets/images/placeholder.png';
  
  /// Empty state illustration
  static const String emptyStatePath = 'assets/images/empty_state.png';
  
  /// Error state illustration
  static const String errorStatePath = 'assets/images/error_state.png';
  
  /// Default avatar
  static const String defaultAvatarPath = 'assets/images/avatar_default.png';

  // ========== PRODUCT IMAGES ==========
  /// LPG 3kg product image
  static const String lpg3kgPath = 'assets/images/products/lpg_3kg.png';
  
  /// LPG 5kg product image
  static const String lpg5kgPath = 'assets/images/products/lpg_5kg.png';
  
  /// LPG 12kg product image
  static const String lpg12kgPath = 'assets/images/products/lpg_12kg.png';
  
  /// Truck image
  static const String truckPath = 'assets/images/products/truck.png';

  // ========== ICONS (SVG) ==========
  /// Home icon
  static const String iconHome = 'assets/icons/ic_home.svg';
  
  /// Delivery icon
  static const String iconDelivery = 'assets/icons/ic_delivery.svg';
  
  /// Maintenance icon
  static const String iconMaintenance = 'assets/icons/ic_maintenance.svg';
  
  /// Profile icon
  static const String iconProfile = 'assets/icons/ic_profile.svg';
  
  /// Settings icon
  static const String iconSettings = 'assets/icons/ic_settings.svg';
  
  /// Logout icon
  static const String iconLogout = 'assets/icons/ic_logout.svg';
  
  /// Add icon
  static const String iconAdd = 'assets/icons/ic_add.svg';
  
  /// Edit icon
  static const String iconEdit = 'assets/icons/ic_edit.svg';
  
  /// Delete icon
  static const String iconDelete = 'assets/icons/ic_delete.svg';
  
  /// Search icon
  static const String iconSearch = 'assets/icons/ic_search.svg';
  
  /// Filter icon
  static const String iconFilter = 'assets/icons/ic_filter.svg';

  // ========== STATUS ICONS ==========
  /// Pending status icon
  static const String iconPending = 'assets/icons/status/ic_pending.svg';
  
  /// On delivery status icon
  static const String iconOnDelivery = 'assets/icons/status/ic_on_delivery.svg';
  
  /// Completed status icon
  static const String iconCompleted = 'assets/icons/status/ic_completed.svg';
  
  /// Cancelled status icon
  static const String iconCancelled = 'assets/icons/status/ic_cancelled.svg';

  // ========== HELPER METHODS ==========
  
  /// Get product image by type
  static String getProductImage(String type) {
    switch (type.toLowerCase()) {
      case '3kg':
      case 'lpg_3kg':
        return lpg3kgPath;
      case '5kg':
      case '5.5kg':
      case 'lpg_5kg':
        return lpg5kgPath;
      case '12kg':
      case 'lpg_12kg':
        return lpg12kgPath;
      default:
        return placeholderPath;
    }
  }

  /// Get status icon by status
  static String getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return iconPending;
      case 'on_delivery':
      case 'on delivery':
        return iconOnDelivery;
      case 'completed':
        return iconCompleted;
      case 'cancelled':
        return iconCancelled;
      default:
        return iconPending;
    }
  }

  /// Get navigation icon by name
  static String getNavigationIcon(String name) {
    switch (name.toLowerCase()) {
      case 'home':
        return iconHome;
      case 'delivery':
      case 'delivery_order':
        return iconDelivery;
      case 'maintenance':
        return iconMaintenance;
      case 'profile':
        return iconProfile;
      default:
        return iconHome;
    }
  }
}
