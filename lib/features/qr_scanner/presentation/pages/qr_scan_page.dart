import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gaspi_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:gaspi_app/features/home/presentation/widgets/role_based_bottom_navigation.dart';
import 'package:gaspi_app/features/qr_scanner/presentation/widgets/asset_options_bottom_sheet.dart';
import 'package:gaspi_app/features/qr_scanner/presentation/widgets/qr_frame_corners.dart';
import 'package:gaspi_app/features/qr_scanner/presentation/widgets/qr_info_section.dart';
import 'package:gaspi_app/features/qr_scanner/presentation/widgets/qr_scanner_header.dart';
import 'package:gaspi_app/features/qr_scanner/presentation/widgets/qr_scanner_overlay_painter.dart';
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
      builder: (context) => const AssetOptionsBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final userRole = user?.role.value ?? 'production';
    final currentRoute = GoRouter.of(context).routerDelegate.currentConfiguration.fullPath;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Full Screen Camera View
          Positioned.fill(
            child: MobileScanner(
              controller: cameraController,
              onDetect: _onDetect,
            ),
          ),

          // Dark Overlay with transparent center
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: screenHeight * 0.40,
            child: CustomPaint(
              painter: QrScannerOverlayPainter(),
            ),
          ),

          // Top Header
          QrScannerHeader(
            onMoreOptionsPressed: _showAssetOptionsBottomSheet,
          ),

          // QR Frame Corners
          const QrFrameCorners(),

          // Check Item Information Section
          QrInfoSection(screenHeight: screenHeight),

          // Bottom Navigation
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: RoleBasedBottomNavigation(
              currentRoute: currentRoute,
              userRole: userRole,
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}