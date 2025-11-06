# Assets Fonts

Folder untuk menyimpan custom fonts.

## Struktur yang Direkomendasikan:

```
assets/fonts/
├── Poppins/
│   ├── Poppins-Regular.ttf
│   ├── Poppins-Medium.ttf
│   ├── Poppins-SemiBold.ttf
│   └── Poppins-Bold.ttf
├── Inter/
│   ├── Inter-Regular.ttf
│   ├── Inter-Medium.ttf
│   └── Inter-Bold.ttf
└── README.md
```

## Cara Setup Font:

### 1. Download Font
- [Google Fonts](https://fonts.google.com/)
- Download format **TTF** atau **OTF**

### 2. Tambahkan ke pubspec.yaml:
```yaml
flutter:
  fonts:
    - family: Poppins
      fonts:
        - asset: assets/fonts/Poppins/Poppins-Regular.ttf
          weight: 400
        - asset: assets/fonts/Poppins/Poppins-Medium.ttf
          weight: 500
        - asset: assets/fonts/Poppins/Poppins-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/Poppins/Poppins-Bold.ttf
          weight: 700
```

### 3. Set Default Font di Theme:
Edit `lib/core/theme/app_theme.dart`:
```dart
static ThemeData get lightTheme {
  return ThemeData(
    fontFamily: 'Poppins',  // Set default font
    // ... rest of theme
  );
}
```

### 4. Gunakan di Code:
```dart
// Auto menggunakan default font
Text('Hello World')

// Override font
Text(
  'Hello World',
  style: TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600, // SemiBold
  ),
)
```

## Font Weight Reference:

| Weight | Value | Common Name |
|--------|-------|-------------|
| 100    | Thin  | Hairline    |
| 200    | ExtraLight | UltraLight |
| 300    | Light | Light       |
| 400    | Regular | Normal    |
| 500    | Medium | Medium     |
| 600    | SemiBold | DemiBold |
| 700    | Bold  | Bold        |
| 800    | ExtraBold | UltraBold |
| 900    | Black | Heavy       |

## Recommended Fonts:

### Modern & Clean:
- **Poppins** - Geometric sans-serif
- **Inter** - System UI alternative
- **Roboto** - Google's material design
- **SF Pro** - iOS system font

### Professional:
- **Open Sans** - Humanist sans-serif
- **Lato** - Serious but friendly
- **Nunito** - Rounded terminals

### Display/Headers:
- **Montserrat** - Bold geometric
- **Raleway** - Elegant sans-serif

## Best Practices:

1. **Limit Font Families**
   - Max 2 font families per app
   - One for body text, one for headers

2. **Include Multiple Weights**
   - Regular (400) - body text
   - Medium (500) - emphasis
   - SemiBold (600) - sub-headers
   - Bold (700) - headers

3. **File Size**
   - TTF generally smaller than OTF
   - Only include weights you'll use
   - Consider using system font alternatives

4. **Licensing**
   - Check font license for commercial use
   - Google Fonts are free & open source

## Font Optimization:

### Use Variable Fonts (if available):
```yaml
fonts:
  - family: Inter
    fonts:
      - asset: assets/fonts/Inter/Inter-VariableFont.ttf
```

Single file contains all weights = smaller app size!

---

**Note:** Setelah menambahkan font:
```bash
flutter pub get
# No need to run build_runner for fonts
```

Font akan otomatis tersedia untuk digunakan.
