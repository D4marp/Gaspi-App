# Quick Start - Theme & Font

## ✅ Setup Complete!

### 🎨 Color Palette
- **Primary**: `#099FE4` (Blue) - `AppTheme.primaryColor`
- **Secondary**: `#5CBA4B` (Green) - `AppTheme.secondaryColor`
- **Tertiary**: `#007EFF` (Blue) - `AppTheme.tertiaryColor`

### 🔤 Font
**Nunito Sans** - Sudah di-set global di seluruh aplikasi

### 📖 Cara Pakai

#### 1. Gunakan Theme (Recommended)
```dart
Text(
  'Hello',
  style: Theme.of(context).textTheme.titleLarge, // Auto pakai Nunito Sans
)

Container(
  color: Theme.of(context).colorScheme.primary, // #099FE4
)
```

#### 2. Gunakan Constants
```dart
Text(
  'Hello',
  style: TextStyle(
    fontFamily: AppTheme.fontFamily, // 'NunitoSans'
    color: AppTheme.primaryColor, // #099FE4
    fontWeight: FontWeight.w600,
  ),
)
```

#### 3. Gunakan Assets Gen
```dart
Text(
  'Hello',
  style: TextStyle(
    fontFamily: Assets.fonts.nunitoSans,
    color: AppTheme.secondaryColor, // #5CBA4B
  ),
)
```

### 📚 Dokumentasi Lengkap
Lihat: `lib/core/theme/THEME_GUIDE.md`

### 🚀 Testing
```bash
flutter run
```

Semua text otomatis pakai Nunito Sans!
