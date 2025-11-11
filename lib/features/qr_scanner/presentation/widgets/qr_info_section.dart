import 'package:flutter/material.dart';

/// Information section widget for QR Scanner
class QrInfoSection extends StatelessWidget {
  final double screenHeight;

  const QrInfoSection({
    super.key,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: screenHeight * 0.60,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.only(
          left: 32,
          right: 32,
          top: 32,
          bottom: 32,
        ),
        decoration: ShapeDecoration(
          color: Colors.grey.shade100,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          shadows: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, -5),
              spreadRadius: 0,
            ),
          ],
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                'Check Item Information',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF242424),
                  fontSize: 18,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w700,
                  height: 1.20,
                ),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: Text(
                'Place the QR code within the frame and wait for it to scan.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF434141),
                  fontSize: 16,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w400,
                  height: 1.60,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
