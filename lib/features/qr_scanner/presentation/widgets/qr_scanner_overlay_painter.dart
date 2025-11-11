import 'package:flutter/material.dart';

/// Custom painter for QR scanner overlay with transparent center
class QrScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;

    // Calculate bottom section height (info + navigation)
    final bottomSectionHeight = size.height * 0.35;

    // Draw dark overlay only on camera area (stop before bottom section)
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height - bottomSectionHeight),
      paint,
    );

    // Clear center area for scanning
    final clearPaint = Paint()..blendMode = BlendMode.clear;

    final scanAreaSize = size.width * 0.65;
    final scanAreaLeft = (size.width - scanAreaSize) / 2;
    final scanAreaTop = 125.0;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          scanAreaLeft,
          scanAreaTop,
          scanAreaSize,
          scanAreaSize * 1.35,
        ),
        const Radius.circular(20),
      ),
      clearPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
