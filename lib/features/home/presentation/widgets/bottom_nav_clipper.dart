import 'package:flutter/material.dart';

/// Custom Clipper untuk Navigation Bar dengan notch/cutout di tengah
class BottomNavClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    
    // Mulai dari kiri atas
    path.lineTo(0, 0);
    
    // Garis horizontal sampai sebelum notch
    final centerX = size.width / 2;
    final notchDepth = 60.0; // Kedalaman notch
    final notchWidth = 45.0; // Lebar setengah notch
    final curveRadius = 15.0; // Radius untuk rounded curve
    final notchStartX = centerX - notchWidth - curveRadius;
    
    path.lineTo(notchStartX, 0);
    
    // Buat notch melengkung dengan rounded edges
    // Curve masuk ke notch (kiri)
    path.quadraticBezierTo(
      notchStartX + curveRadius / 2, 0,
      notchStartX + curveRadius, curveRadius,
    );
    
    // Arc untuk notch utama (lengkungan ke bawah)
    path.arcToPoint(
      Offset(centerX + notchWidth, curveRadius),
      radius: Radius.circular(notchDepth),
      clockwise: false,
    );
    
    // Curve keluar dari notch (kanan)
    path.quadraticBezierTo(
      centerX + notchWidth + curveRadius / 2, 0,
      centerX + notchWidth + curveRadius, 0,
    );
    
    // Lanjut ke kanan
    path.lineTo(size.width, 0);
    
    // Garis ke bawah
    path.lineTo(size.width, size.height);
    
    // Garis horizontal bawah
    path.lineTo(0, size.height);
    
    // Tutup path
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
