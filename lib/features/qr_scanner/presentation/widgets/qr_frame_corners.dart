import 'package:flutter/material.dart';

/// QR Frame corners widget
class QrFrameCorners extends StatelessWidget {
  const QrFrameCorners({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 71,
      top: 125,
      child: SizedBox(
        width: 248,
        height: 336.53,
        child: Stack(
          children: [
            // Top Left Corner
            Positioned(
              left: 0,
              top: 0,
              child: _buildCorner(),
            ),
            // Top Right Corner
            Positioned(
              right: 0,
              top: 0,
              child: Transform.flip(
                flipX: true,
                child: _buildCorner(),
              ),
            ),
            // Bottom Left Corner
            Positioned(
              left: 0,
              bottom: 0,
              child: Transform.flip(
                flipY: true,
                child: _buildCorner(),
              ),
            ),
            // Bottom Right Corner
            Positioned(
              right: 0,
              bottom: 0,
              child: Transform(
                transform: Matrix4.identity()..rotateZ(3.14159),
                alignment: Alignment.center,
                child: _buildCorner(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCorner() {
    return Container(
      width: 89.21,
      height: 133.37,
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
