# Assets Icons

Folder untuk menyimpan icon aplikasi.

## Struktur yang Direkomendasikan:

```
assets/icons/
├── navigation/
│   ├── ic_home.svg
│   ├── ic_delivery.svg
│   ├── ic_maintenance.svg
│   └── ic_profile.svg
├── actions/
│   ├── ic_add.svg
│   ├── ic_edit.svg
│   ├── ic_delete.svg
│   └── ic_search.svg
├── status/
│   ├── ic_pending.svg
│   ├── ic_on_delivery.svg
│   ├── ic_completed.svg
│   └── ic_cancelled.svg
└── categories/
    ├── ic_lpg_3kg.svg
    ├── ic_lpg_12kg.svg
    └── ic_truck.svg
```

## Format yang Disarankan:
- **SVG** - Vector graphics, scalable, ukuran kecil (RECOMMENDED)
- **PNG** - Raster graphics dengan transparansi

## Size Guidelines:
- Navigation icons: 24x24dp
- Action icons: 24x24dp  
- Status icons: 20x20dp
- Category icons: 32x32dp

## Color:
- Gunakan **single color** untuk kemudahan theming
- Biarkan fill/stroke bisa di-override dari code
- Untuk multi-color icons, simpan dalam PNG

## Naming Convention:
- Prefix: `ic_` untuk icon
- Gunakan **snake_case**
- Deskriptif dan jelas
- Contoh: `ic_delivery_truck.svg`, `ic_status_completed.svg`

## SVG Optimization:
- Gunakan tool seperti [SVGO](https://jakearchibald.github.io/svgomg/)
- Remove metadata, comments
- Optimize paths
- Keep viewBox attribute

---

**Note:** Untuk menggunakan SVG, tambahkan dependency:
```yaml
dependencies:
  flutter_svg: ^2.0.9
```

Kemudian jalankan:
```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```
