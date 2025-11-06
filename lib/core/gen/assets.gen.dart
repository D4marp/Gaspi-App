/// GENERATED CODE - DO NOT MODIFY BY HAND
/// This is a type-safe helper class for accessing assets
/// 
/// Usage:
/// ```dart
/// Image.asset(Assets.images.logo)
/// SvgPicture.asset(Assets.icons.home)
/// ```

import 'package:flutter/widgets.dart';

class Assets {
  Assets._();

  /// Images
  static const $AssetsImagesGen images = $AssetsImagesGen();

  /// Icons
  static const $AssetsIconsGen icons = $AssetsIconsGen();

  /// Logos
  static const $AssetsLogosGen logos = $AssetsLogosGen();
}

/// Images Generator
class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Base path for images
  static const String _basePath = 'assets/images';

  // Add your images here, example:
  // String get logo => '$_basePath/logo.png';
  // String get background => '$_basePath/background.jpg';
  // String get avatar => '$_basePath/avatar.png';
  
  /// Get full path for image
  String getPath(String fileName) => '$_basePath/$fileName';
}

/// Icons Generator
class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// Base path for icons
  static const String _basePath = 'assets/icons';

  // Add your icons here, example:
  // String get home => '$_basePath/home.svg';
  // String get delivery => '$_basePath/delivery.svg';
  // String get maintenance => '$_basePath/maintenance.svg';
  // String get profile => '$_basePath/profile.svg';
  
  /// Get full path for icon
  String getPath(String fileName) => '$_basePath/$fileName';
}

/// Logos Generator
class $AssetsLogosGen {
  const $AssetsLogosGen();

  /// Base path for logos
  static const String _basePath = 'assets/logos';

  // Add your logos here, example:
  // String get appLogo => '$_basePath/app_logo.png';
  // String get appLogoWhite => '$_basePath/app_logo_white.png';
  // String get companyLogo => '$_basePath/company_logo.png';
  
  /// Get full path for logo
  String getPath(String fileName) => '$_basePath/$fileName';
}

/// Extension for easier image loading
extension AssetImageExtension on String {
  /// Load as Image widget
  Image toImage({
    double? width,
    double? height,
    BoxFit? fit,
  }) {
    return Image.asset(
      this,
      width: width,
      height: height,
      fit: fit,
    );
  }

  /// Load as AssetImage
  AssetImage toAssetImage() {
    return AssetImage(this);
  }
}
