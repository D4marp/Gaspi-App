import 'package:flutter/material.dart';

/// QR Frame corners widget - Responsive version
class QrFrameCorners extends StatelessWidget {
  const QrFrameCorners({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    // Responsive sizing
    final scanAreaSize = screenWidth * 0.65;
    final scanAreaLeft = (screenWidth - scanAreaSize) / 2;
    final scanAreaTop = screenHeight * 0.15; // 15% from top
    final scanAreaHeight = scanAreaSize * 1.35;
    
    // Corner size relative to scan area
    final cornerWidth = scanAreaSize * 0.36; // ~36% of scan area
    final cornerHeight = cornerWidth * 1.5; // Maintain aspect ratio
    
    return Positioned(
      left: scanAreaLeft,
      top: scanAreaTop,
      child: SizedBox(
        width: scanAreaSize,
        height: scanAreaHeight,
        child: Stack(
          children: [
            // Top Left Corner
            Positioned(
              left: 0,
              top: 0,
              child: _buildCorner(cornerWidth, cornerHeight),
            ),
            // Top Right Corner
            Positioned(
              right: 0,
              top: 0,
              child: Transform.flip(
                flipX: true,
                child: _buildCorner(cornerWidth, cornerHeight),
              ),
            ),
            // Bottom Left Corner
            Positioned(
              left: 0,
              bottom: 0,
              child: Transform.flip(
                flipY: true,
                child: _buildCorner(cornerWidth, cornerHeight),
              ),
            ),
            // Bottom Right Corner
            Positioned(
              right: 0,
              bottom: 0,
              child: Transform(
                transform: Matrix4.identity()..rotateZ(3.14159),
                alignment: Alignment.center,
                child: _buildCorner(cornerWidth, cornerHeight),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCorner(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.white, width: 6),
          top: BorderSide(color: Colors.white, width: 6),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
        ),
      ),
    );
  }
}
