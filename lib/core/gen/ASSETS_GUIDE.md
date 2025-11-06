# 🎨 Assets Management dengan Flutter Gen

Type-safe asset management untuk Gaspi Mobile App.

---

## 📂 Struktur Folder

```
assets/
├── images/          # Gambar aplikasi (PNG, JPG, WebP)
├── icons/           # Icon aplikasi (SVG, PNG)
├── logos/           # Logo aplikasi dan company
└── fonts/           # Custom fonts (TTF, OTF)
```

---

## 🚀 Cara Menggunakan

### 1. Tambahkan Assets

**Contoh menambahkan gambar:**
```
assets/images/logo.png
assets/images/background.jpg
assets/images/products/lpg_3kg.png
```

**Contoh menambahkan icon:**
```
assets/icons/ic_home.svg
assets/icons/ic_delivery.svg
assets/icons/ic_maintenance.svg
```

**Contoh menambahkan logo:**
```
assets/logos/app_logo.png
assets/logos/app_logo_white.png
assets/logos/company_logo.png
```

### 2. Update Helper Class

Edit `lib/core/gen/assets.gen.dart` dan tambahkan path assets:

```dart
class $AssetsImagesGen {
  const $AssetsImagesGen();
  static const String _basePath = 'assets/images';

  // Tambahkan assets Anda di sini:
  String get logo => '$_basePath/logo.png';
  String get background => '$_basePath/background.jpg';
  
  // Untuk subfolder
  $AssetsImagesProductsGen get products => const $AssetsImagesProductsGen();
}

// Subfolder generator
class $AssetsImagesProductsGen {
  const $AssetsImagesProductsGen();
  static const String _basePath = 'assets/images/products';
  
  String get lpg3kg => '$_basePath/lpg_3kg.png';
  String get lpg5kg => '$_basePath/lpg_5kg.png';
  String get lpg12kg => '$_basePath/lpg_12kg.png';
}
```

### 3. Gunakan di Code

#### Untuk Gambar (PNG/JPG):
```dart
import 'package:flutter/material.dart';
import '../../core/gen/assets.gen.dart';

// Method 1: Langsung
Image.asset(Assets.images.logo)

// Method 2: Dengan parameter
Image.asset(
  Assets.images.background,
  width: 200,
  height: 100,
  fit: BoxFit.cover,
)

// Method 3: Menggunakan extension
Assets.images.logo.toImage(
  width: 150,
  height: 150,
  fit: BoxFit.contain,
)

// Method 4: Sebagai background
Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: Assets.images.background.toAssetImage(),
      fit: BoxFit.cover,
    ),
  ),
)
```

#### Untuk Icon SVG:
```dart
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/gen/assets.gen.dart';

// Render SVG icon
SvgPicture.asset(
  Assets.icons.home,
  width: 24,
  height: 24,
  color: Colors.blue,
)

// SVG dengan color theme
SvgPicture.asset(
  Assets.icons.delivery,
  width: 24,
  height: 24,
  colorFilter: ColorFilter.mode(
    Theme.of(context).primaryColor,
    BlendMode.srcIn,
  ),
)
```

#### Untuk Logo:
```dart
// App logo
Image.asset(
  Assets.logos.appLogo,
  width: 120,
)

// Logo putih untuk dark background
Image.asset(
  Assets.logos.appLogoWhite,
  width: 120,
)
```

---

## 📝 Contoh Implementasi

### LoginPage dengan Logo:
```dart
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.background.toAssetImage(),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo
              Image.asset(
                Assets.logos.appLogo,
                width: 150,
              ),
              SizedBox(height: 32),
              // Login Form
              // ...
            ],
          ),
        ),
      ),
    );
  }
}
```

### BottomNavigationBar dengan Icon:
```dart
BottomNavigationBar(
  items: [
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        Assets.icons.home,
        width: 24,
        height: 24,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        Assets.icons.delivery,
        width: 24,
        height: 24,
      ),
      label: 'Delivery',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        Assets.icons.maintenance,
        width: 24,
        height: 24,
      ),
      label: 'Maintenance',
    ),
  ],
)
```

### Product Card dengan Image:
```dart
class ProductCard extends StatelessWidget {
  final String productType;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.asset(
            _getProductImage(productType),
            width: 100,
            height: 100,
            fit: BoxFit.contain,
          ),
          Text(productType),
        ],
      ),
    );
  }

  String _getProductImage(String type) {
    switch (type) {
      case '3kg':
        return Assets.images.products.lpg3kg;
      case '5kg':
        return Assets.images.products.lpg5kg;
      case '12kg':
        return Assets.images.products.lpg12kg;
      default:
        return Assets.images.logo;
    }
  }
}
```

---

## 🎯 Best Practices

### 1. Naming Convention
```dart
// ✅ GOOD - snake_case
Assets.images.app_logo
Assets.icons.ic_home
Assets.images.bg_login

// ❌ BAD
Assets.images.AppLogo
Assets.icons.Home
Assets.images.bgLogin
```

### 2. Organize by Feature
```
assets/
├── images/
│   ├── auth/
│   │   ├── bg_login.png
│   │   └── illustration_welcome.png
│   ├── products/
│   │   ├── lpg_3kg.png
│   │   ├── lpg_5kg.png
│   │   └── lpg_12kg.png
│   └── common/
│       ├── empty_state.png
│       └── error_state.png
```

### 3. Gunakan SVG untuk Icons
```dart
// ✅ GOOD - Scalable, ukuran kecil
SvgPicture.asset(Assets.icons.home)

// ❌ AVOID - Banyak resolution, ukuran besar
Image.asset('assets/icons/home.png')
Image.asset('assets/icons/home@2x.png')
Image.asset('assets/icons/home@3x.png')
```

### 4. Cache Network Images
```dart
import 'package:cached_network_image/cached_network_image.dart';

CachedNetworkImage(
  imageUrl: 'https://api.gaspi.com/products/image.jpg',
  placeholder: (context, url) => Image.asset(
    Assets.images.placeholder,
  ),
  errorWidget: (context, url, error) => Image.asset(
    Assets.images.errorPlaceholder,
  ),
)
```

### 5. Lazy Loading untuk Large Images
```dart
// Preload images
void _preloadImages() {
  precacheImage(
    Assets.images.background.toAssetImage(),
    context,
  );
}

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  _preloadImages();
}
```

---

## 🔧 Troubleshooting

### Problem: "Unable to load asset"
**Solution:**
```bash
# 1. Clean build
flutter clean

# 2. Get dependencies
flutter pub get

# 3. Restart app
flutter run
```

### Problem: Image tidak tampil
**Solution:**
```dart
// Check path di pubspec.yaml
flutter:
  assets:
    - assets/images/
    - assets/icons/
    - assets/logos/

// Check file exists di folder
assets/images/logo.png  ✅
assets/image/logo.png   ❌ (typo: image vs images)
```

### Problem: SVG tidak render
**Solution:**
```yaml
# Tambahkan dependency
dependencies:
  flutter_svg: ^2.0.9

# Kemudian
flutter pub get
```

---

## 📦 Dependencies yang Dibutuhkan

### Untuk SVG Support:
```yaml
dependencies:
  flutter_svg: ^2.0.9
```

### Untuk Cached Images:
```yaml
dependencies:
  cached_network_image: ^3.3.1
```

### Untuk Lottie Animations:
```yaml
dependencies:
  lottie: ^3.0.0
```

---

## ✅ Checklist

- [x] Folder assets created
- [x] Assets helper class created (`lib/core/gen/assets.gen.dart`)
- [x] pubspec.yaml configured
- [ ] Add actual image files
- [ ] Add actual icon files
- [ ] Add actual logo files
- [ ] Update helper class with actual asset paths
- [ ] Test images render correctly

---

## 📞 Next Steps

1. **Design Assets** - Buat atau download assets yang dibutuhkan
2. **Add to Project** - Copy ke folder `assets/`
3. **Update Helper** - Edit `assets.gen.dart` dengan path yang benar
4. **Test** - Run app dan pastikan assets tampil
5. **Optimize** - Compress images, optimize SVG

---

**Happy Coding! 🎨📱**
