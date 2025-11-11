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
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      await cameraController.start();
    } catch (e) {
      debugPrint('Error initializing camera: $e');
      if (mounted) {
        setState(() {
          hasError = true;
        });
      }
    }
  }

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

  void _showAssetOptionsBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        width: 390,
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title Section
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 32),
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 326,
                    child: Text(
                      'What asset are you looking for?',
                      style: TextStyle(
                        color: Color(0xFF242424),
                        fontSize: 18,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w700,
                        height: 1.20,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Options List
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Registered Cylinders
                _buildAssetOption(
                  title: 'Registered Cylinders',
                  description: 'Check the information of your cylinder assets.',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to cylinders page
                  },
                ),
                const SizedBox(height: 24),

                // Registered Transport Racks
                _buildAssetOption(
                  title: 'Registered Transport Racks',
                  description: 'Check the information of your Transport Rack assets.',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to transport racks page
                  },
                ),
                const SizedBox(height: 24),

                // Registered Manifolds
                _buildAssetOption(
                  title: 'Registered Manifolds',
                  description: 'Check the information of your manifold assets.',
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Navigate to manifolds page
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetOption({
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 326,
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 24,
              height: 24,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF007EFF).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(
                Icons.inventory_2_outlined,
                size: 16,
                color: Color(0xFF007EFF),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF393D4E),
                      fontSize: 14,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w600,
                      height: 1.20,
                      letterSpacing: -0.28,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Color(0xFF677487),
                      fontSize: 12,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w400,
                      height: 1.40,
                      letterSpacing: -0.24,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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

          // Dark Overlay with transparent center (Stop before bottom section)
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: screenHeight * 0.39, // Stop before info section
            child: CustomPaint(
              painter: QrScannerOverlayPainter(),
            ),
          ),

          // Top Header (Higher position)
          Positioned(
            left: 40,
            top: 0,
            right: 40,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.only(top: 8), // Minimal top padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Back Button - Fixed with proper Material wrapper
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          debugPrint('Back button tapped!');
                          // Navigate back to home instead of pop
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.go('/home');
                          }
                        },
                        borderRadius: BorderRadius.circular(100),
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

                    // More Options Button (3 dots)
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          debugPrint('More options tapped!');
                          _showAssetOptionsBottomSheet();
                        },
                        borderRadius: BorderRadius.circular(100),
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
                          child: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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

          // Bottom Section - Single White Container (Info + Navigation)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: screenWidth,
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Info Text Section
                  Padding(
                    padding: const EdgeInsets.only(left: 32, right: 32, top: 32, bottom: 16),
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
                  // Navigation Bar with transparent background
                  RoleBasedBottomNavigation(
                    currentRoute: currentRoute,
                    userRole: userRole,
                    backgroundColor: Colors.transparent, // Make navigation transparent
                  ),
                ],
              ),
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

    // Calculate bottom section height (info + navigation)
    final bottomSectionHeight = size.height * 0.35; // Approximate height of bottom section

    // Draw dark overlay only on camera area (stop before bottom section)
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height - bottomSectionHeight),
      paint,
    );

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
