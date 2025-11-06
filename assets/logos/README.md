# Assets Logos

Folder untuk menyimpan logo aplikasi dan brand assets.

## Struktur yang Direkomendasikan:

```
assets/logos/
├── app_logo.png              # Logo utama aplikasi
├── app_logo_white.png        # Logo putih untuk dark background
├── app_logo_icon.png         # Icon only (square)
├── company_logo.png          # Logo perusahaan
├── company_logo_horizontal.png
└── splash_logo.png           # Logo untuk splash screen
```

## Format:
- **PNG** dengan transparansi
- **SVG** untuk scalability (jika ada)

## Size Guidelines:

### App Logo (Full)
- Width: 240-320px
- Height: Proportional
- Transparent background

### App Icon (Square)
- Size: 512x512px atau 1024x1024px
- Transparent background
- Padding: 10-15% dari size

### Splash Logo
- Width: 240px
- Height: Proportional
- Centered on screen

## Color Variants:
Siapkan minimal 2 varian:
1. **Primary** - Logo warna asli
2. **White/Light** - Untuk dark background
3. **Dark/Black** - Untuk light background (optional)

## Naming Convention:
- Gunakan **snake_case**
- Prefix dengan tipe logo
- Include variant in name
- Contoh: 
  - `app_logo.png`
  - `app_logo_white.png`
  - `company_logo_horizontal.png`

## Resolution:
Untuk logo, sediakan resolusi tinggi:
- **@1x** - base (misal 240px)
- **@2x** - 2x base (480px)
- **@3x** - 3x base (720px)

Atau langsung gunakan **SVG** untuk auto-scaling.

---

**Note:** Setelah menambahkan logo, jalankan:
```bash
dart run build_runner build --delete-conflicting-outputs
```

Logo akan tersedia di:
```dart
Assets.logos.appLogo
Assets.logos.appLogoWhite
```
