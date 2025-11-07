# Fonts Directory

## Nunito Sans Font Family

Font yang digunakan di aplikasi Gaspi adalah **Nunito Sans**.

### Download Font
Download Nunito Sans dari Google Fonts:
https://fonts.google.co[text](../../../../../Downloads/Nunito_Sans/NunitoSans-VariableFont_YTLC,opsz,wdth,wght.ttf) [text](../../../../../Downloads/Nunito_Sans/NunitoSans-Italic-VariableFont_YTLC,opsz,wdth,wght.ttf)m/specimen/Nunito+Sans

### File yang Dibutuhkan
Letakkan file-file berikut di folder `assets/fonts/`:

1. `NunitoSans-Regular.ttf` (weight: 400)
2. `NunitoSans-Medium.ttf` (weight: 500)
3. `NunitoSans-SemiBold.ttf` (weight: 600)
4. `NunitoSans-Bold.ttf` (weight: 700)
5. `NunitoSans-ExtraBold.ttf` (weight: 800)

### Penggunaan

Font Nunito Sans sudah diset sebagai font global di `AppTheme`.

#### Cara Menggunakan di Code:

```dart
// Otomatis menggunakan Nunito Sans karena sudah set di theme
Text(
  'Hello World',
  style: Theme.of(context).textTheme.titleLarge,
)

// Atau manual
Text(
  'Hello World',
  style: TextStyle(
    fontFamily: 'NunitoSans',
    fontSize: 16,
    fontWeight: FontWeight.w600, // SemiBold
  ),
)
```

### Font Weights yang Tersedia:
- `FontWeight.w400` - Regular
- `FontWeight.w500` - Medium
- `FontWeight.w600` - SemiBold
- `FontWeight.w700` - Bold
- `FontWeight.w800` - ExtraBold

## Catatan
Setelah menambahkan font files, jalankan:
```bash
flutter pub get
flutter clean
flutter run
```
