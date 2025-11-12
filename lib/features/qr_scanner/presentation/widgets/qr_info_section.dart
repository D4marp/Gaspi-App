import 'package:flutter/material.dart';

/// Information section widget for QR Scanner - Responsive
class QrInfoSection extends StatelessWidget {
  final double screenHeight;

  const QrInfoSection({
    super.key,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    // Responsive padding and font sizes
    final horizontalPadding = screenWidth * 0.08; // 8% of screen width
    final verticalPadding = screenHeight * 0.035; // 3.5% of screen height
    final titleFontSize = screenWidth * 0.045; // 4.5% of screen width
    final descFontSize = screenWidth * 0.04; // 4% of screen width
    
    return Positioned(
      left: 0,
      right: 0,
      top: screenHeight * 0.60,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.only(
          left: horizontalPadding,
          right: horizontalPadding,
          top: verticalPadding,
          bottom: verticalPadding,
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                'Check Item Information',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF242424),
                  fontSize: titleFontSize,
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w700,
                  height: 1.20,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02), // 2% of screen height
            SizedBox(
              width: double.infinity,
              child: Text(
                'Place the QR code within the frame and wait for it to scan.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF434141),
                  fontSize: descFontSize,
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
