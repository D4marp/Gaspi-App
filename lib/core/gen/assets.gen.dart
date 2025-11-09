// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/QR.svg
  String get qr => 'assets/icons/QR.svg';

  /// File path: assets/icons/README.md
  String get readme => 'assets/icons/README.md';

  /// File path: assets/icons/add.svg
  String get add => 'assets/icons/add.svg';

  /// File path: assets/icons/award.svg
  String get award => 'assets/icons/award.svg';

  /// File path: assets/icons/box.svg
  String get box => 'assets/icons/box.svg';

  /// File path: assets/icons/convert-3d-cube.svg
  String get convert3dCube => 'assets/icons/convert-3d-cube.svg';

  /// File path: assets/icons/document-text.svg
  String get documentText => 'assets/icons/document-text.svg';

  /// File path: assets/icons/home-2.svg
  String get home2 => 'assets/icons/home-2.svg';

  /// File path: assets/icons/mdi_gas-cylinder.svg
  String get mdiGasCylinder => 'assets/icons/mdi_gas-cylinder.svg';

  /// File path: assets/icons/menu.svg
  String get menu => 'assets/icons/menu.svg';

  /// File path: assets/icons/people.svg
  String get people => 'assets/icons/people.svg';

  /// File path: assets/icons/profile-circle.svg
  String get profileCircle => 'assets/icons/profile-circle.svg';

  /// File path: assets/icons/setting-2.svg
  String get setting2 => 'assets/icons/setting-2.svg';

  /// File path: assets/icons/shield-tick bold.svg
  String get shieldTickBold => 'assets/icons/shield-tick bold.svg';

  /// File path: assets/icons/shield-tick.svg
  String get shieldTick => 'assets/icons/shield-tick.svg';

  /// File path: assets/icons/shop.svg
  String get shop => 'assets/icons/shop.svg';

  /// File path: assets/icons/stickynote.svg
  String get stickynote => 'assets/icons/stickynote.svg';

  /// File path: assets/icons/task.svg
  String get task => 'assets/icons/task.svg';

  /// File path: assets/icons/truck-fast.svg
  String get truckFast => 'assets/icons/truck-fast.svg';

  /// File path: assets/icons/user-tag.svg
  String get userTag => 'assets/icons/user-tag.svg';

  /// List of all assets
  List<String> get values => [
    qr,
    readme,
    add,
    award,
    box,
    convert3dCube,
    documentText,
    home2,
    mdiGasCylinder,
    menu,
    people,
    profileCircle,
    setting2,
    shieldTickBold,
    shieldTick,
    shop,
    stickynote,
    task,
    truckFast,
    userTag,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/README.md
  String get readme => 'assets/images/README.md';

  /// File path: assets/images/navigation.svg
  String get navigation => 'assets/images/navigation.svg';

  /// File path: assets/images/onboarding_1.png
  AssetGenImage get onboarding1 =>
      const AssetGenImage('assets/images/onboarding_1.png');

  /// File path: assets/images/onboarding_2.png
  AssetGenImage get onboarding2 =>
      const AssetGenImage('assets/images/onboarding_2.png');

  /// File path: assets/images/onboarding_3.png
  AssetGenImage get onboarding3 =>
      const AssetGenImage('assets/images/onboarding_3.png');

  /// File path: assets/images/onboarding_bg.png
  AssetGenImage get onboardingBg =>
      const AssetGenImage('assets/images/onboarding_bg.png');

  /// List of all assets
  List<dynamic> get values => [
    readme,
    navigation,
    onboarding1,
    onboarding2,
    onboarding3,
    onboardingBg,
  ];
}

class $AssetsLogosGen {
  const $AssetsLogosGen();

  /// File path: assets/logos/README.md
  String get readme => 'assets/logos/README.md';

  /// File path: assets/logos/logo.svg
  String get logo => 'assets/logos/logo.svg';

  /// File path: assets/logos/splash.svg
  String get splash => 'assets/logos/splash.svg';

  /// List of all assets
  List<String> get values => [readme, logo, splash];
}

class Assets {
  const Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsLogosGen logos = $AssetsLogosGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
