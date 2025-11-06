# Assets Images

Folder untuk menyimpan gambar aplikasi.

## Struktur yang Direkomendasikan:

```
assets/images/
├── backgrounds/
│   ├── bg_login.png
│   └── bg_home.png
├── products/
│   ├── lpg_3kg.png
│   ├── lpg_5kg.png
│   └── lpg_12kg.png
├── illustrations/
│   ├── empty_state.png
│   └── error_state.png
└── avatars/
    └── default_avatar.png
```

## Format yang Disarankan:
- **PNG** untuk gambar dengan transparansi
- **JPG** untuk foto/gambar tanpa transparansi
- **WebP** untuk ukuran file lebih kecil (Android support)

## Resolution:
- **1x** - base resolution
- **2x** - untuk retina display
- **3x** - untuk high-end devices

## Ukuran Maksimal:
- Background: max 1920x1080px
- Product images: max 512x512px
- Illustrations: max 800x800px
- Avatars: max 256x256px

## Naming Convention:
- Gunakan **snake_case**
- Deskriptif dan jelas
- Contoh: `ic_delivery_truck.png`, `bg_login_gradient.png`

---

**Note:** Setelah menambahkan gambar baru, jalankan:
```bash
dart run build_runner build --delete-conflicting-outputs
```

Untuk generate type-safe asset references di `lib/core/gen/assets.gen.dart`
