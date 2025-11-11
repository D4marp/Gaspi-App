# QR Scanner Feature

## Overview
Feature untuk scan QR code menggunakan kamera device dengan UI yang menarik dan modern.

## Library Used
- **mobile_scanner** v5.2.3 - Library untuk scanning QR/Barcode dengan performa tinggi

## Features
✅ Full screen camera view
✅ Dark overlay dengan area scan transparan
✅ Corner frames untuk visual guide
✅ Flash toggle button
✅ Back button
✅ Auto-detect QR code
✅ Result dialog dengan opsi scan again

## File Structure
```
lib/features/qr_scanner/
└── presentation/
    └── pages/
        ├── index.dart
        └── qr_scan_page.dart
```

## Design Components

### 1. Camera View
- Full screen camera dengan `MobileScanner` widget
- Auto-focus dan auto-detect QR code

### 2. Overlay
- Dark overlay (60% opacity) dengan area tengah transparan
- Custom painter untuk membuat efek overlay
- Scan area: 65% dari lebar layar

### 3. Header
- Back button (kiri)
- Title "Scan QR Code" (tengah dengan background blur)
- Flash toggle button (kanan)

### 4. Corner Frames
- 4 corner frames putih untuk visual guide
- Posisi: Top-left, Top-right, Bottom-left, Bottom-right
- Ukuran: 89.21 x 133.37 pixels
- Border width: 6px

### 5. Bottom Info Section
- White container dengan rounded top corners
- Title: "Check Item Information"
- Instruction text
- Dynamic bottom padding untuk navigation bar

## Permissions Required

### Android
```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-feature android:name="android.hardware.camera" />
<uses-feature android:name="android.hardware.camera.autofocus" />
```

### iOS
```xml
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to scan QR codes</string>
```

## Usage

### Navigation
```dart
// From any page
context.go('/qr-scan');

// Or with Navigator
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const QrScanPage()),
);
```

### Handle QR Result
Ketika QR code terdeteksi, akan muncul dialog dengan:
- QR code value
- Button "Scan Again" - untuk scan ulang
- Button "OK" - untuk close dan kembali

## Customization

### Ubah Scan Area Size
```dart
// Di QrScannerOverlayPainter
final scanAreaSize = size.width * 0.65; // Ubah 0.65 sesuai kebutuhan
```

### Ubah Overlay Opacity
```dart
final paint = Paint()
  ..color = Colors.black.withValues(alpha: 0.6) // Ubah 0.6 (0-1)
  ..style = PaintingStyle.fill;
```

### Ubah Corner Frame Style
```dart
Widget _buildCorner() {
  return Container(
    width: 89.21,
    height: 133.37,
    decoration: BoxDecoration(
      border: Border(
        left: BorderSide(color: Colors.white, width: 6), // Ubah width
        top: BorderSide(color: Colors.white, width: 6),
      ),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20), // Ubah radius
      ),
    ),
  );
}
```

## Technical Notes

### Camera Controller
```dart
MobileScannerController cameraController = MobileScannerController();

// Lifecycle management
@override
void dispose() {
  cameraController.dispose(); // Important!
  super.dispose();
}
```

### Flash Control
```dart
void _onFlashTap() {
  setState(() {
    isFlashOn = !isFlashOn;
  });
  cameraController.toggleTorch();
}
```

### Detection Handler
```dart
void _onDetect(BarcodeCapture capture) {
  final List<Barcode> barcodes = capture.barcodes;
  for (final barcode in barcodes) {
    final String? code = barcode.rawValue;
    if (code != null) {
      cameraController.stop(); // Stop scanning
      // Handle result
      break;
    }
  }
}
```

## Design Specs (Figma)

### Colors
- Background: Black (camera view)
- Overlay: Black 60% opacity
- Corners: White
- Header buttons background: Black 10% opacity
- Bottom section: White

### Spacing
- Header horizontal padding: 40px
- Header vertical padding: 32px (with SafeArea)
- Bottom section padding: 32px
- Corner frame position: 71px dari kiri, 125px dari atas

### Typography
- Title: 20px, Nunito Sans Bold, White
- Info title: 18px, Nunito Sans Bold, #242424
- Info text: 16px, Nunito Sans Regular, #434141

### Border Radius
- Header buttons: 100px (circular)
- Title background: 30px
- Bottom section: 30px (top corners only)
- Corner frames: 20px

## Testing

### Test on Simulator
Note: Camera tidak akan bekerja di simulator. Test harus dilakukan di real device.

### Test Flow
1. Tap QR button di navigation
2. Allow camera permission (first time)
3. Point camera ke QR code
4. Auto-detect dan show dialog
5. Test "Scan Again" button
6. Test "OK" button
7. Test back button
8. Test flash toggle

## Future Enhancements
- [ ] Support scan dari gallery
- [ ] History scan results
- [ ] Multiple QR detection
- [ ] Custom QR result handler
- [ ] Zoom controls
- [ ] Manual focus tap
- [ ] Sound effect saat scan
- [ ] Vibration feedback

## Dependencies Update
Jika ingin update library:
```bash
flutter pub upgrade mobile_scanner
```

Check breaking changes di: https://pub.dev/packages/mobile_scanner/changelog
