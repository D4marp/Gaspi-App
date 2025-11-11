import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaspi_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:gaspi_app/features/home/presentation/widgets/role_based_bottom_navigation.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanPage extends ConsumerStatefulWidget {
  const QrScanPage({super.key});

  @override
  ConsumerState<QrScanPage> createState() => _QrScanPageState();
}

class _QrScanPageState extends ConsumerState<QrScanPage> {
  MobileScannerController cameraController = MobileScannerController();
  bool isFlashOn = false;

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      final String? code = barcode.rawValue;
      if (code != null) {
        // Stop camera and show result
        cameraController.stop();
        _showResultDialog(code);
        break;
      }
    }
  }

  void _showResultDialog(String code) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'QR Code Detected',
          style: TextStyle(
            fontFamily: 'Nunito Sans',
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Code: $code',
          style: const TextStyle(
            fontFamily: 'Nunito Sans',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              cameraController.start();
            },
            child: const Text('Scan Again'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final userRole = user?.role.value ?? 'production';
    final currentRoute = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Full Screen Camera View - PURE CAMERA
          Positioned.fill(
            child: MobileScanner(
              controller: cameraController,
              onDetect: _onDetect,
            ),
          ),

          // Dark Overlay with transparent center
          Positioned.fill(
            child: CustomPaint(
              painter: QrScannerOverlayPainter(),
            ),
          ),

          // Top Header with SafeArea
          Positioned(
            left: 40,
            top: 32,
            right: 40,
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Back Button
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: ShapeDecoration(
                        color: const Color(0x190F0F0F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),

                  // Title
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: ShapeDecoration(
                          color: const Color(0x190F0F0F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Scan QR Code',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w700,
                            height: 1.20,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Flash Button
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isFlashOn = !isFlashOn;
                      });
                      cameraController.toggleTorch();
                    },
                    child: Container(
                      width: 44,
                      height: 44,
                      padding: const EdgeInsets.all(10),
                      decoration: ShapeDecoration(
                        color: const Color(0x190F0F0F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: Icon(
                        isFlashOn ? Icons.flash_on : Icons.flash_off,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // QR Frame Corners
          Positioned(
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
          ),

          // Bottom Info Section (Above Navigation)
          Positioned(
            left: 0,
            right: 0,
            bottom: screenHeight * 0.11, // Above navigation bar
            child: Container(
              width: screenWidth,
              padding: const EdgeInsets.all(32),
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
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
                  SizedBox(height: 24),
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
          ),

          // Bottom Navigation Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: RoleBasedBottomNavigation(
              currentRoute: currentRoute,
              userRole: userRole,
            ),
          ),
        ],
      ),
    );
  }

  /// Build corner decoration for QR frame
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

/// Custom painter untuk overlay gelap dengan area transparan di tengah
class QrScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;

    // Draw dark overlay
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Clear center area for scanning
    final clearPaint = Paint()
      ..blendMode = BlendMode.clear;

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
