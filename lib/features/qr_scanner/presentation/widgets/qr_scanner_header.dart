import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Header widget for QR Scanner with back button, title, and more options - Responsive
class QrScannerHeader extends StatelessWidget {
  final VoidCallback onMoreOptionsPressed;

  const QrScannerHeader({
    super.key,
    required this.onMoreOptionsPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.05; // 5% of screen width
    
    return Positioned(
      left: horizontalPadding,
      top: 0,
      right: horizontalPadding,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Back Button
              _BackButton(),

              // Title
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04), // 4% padding
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: ShapeDecoration(
                      color: const Color(0x190F0F0F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Scan QR Code',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.05, // 5% of screen width
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w700,
                        height: 1.20,
                      ),
                    ),
                  ),
                ),
              ),

              // More Options Button (3 dots)
              _MoreOptionsButton(onPressed: onMoreOptionsPressed),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          debugPrint('Back button tapped!');
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
    );
  }
}

class _MoreOptionsButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _MoreOptionsButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          debugPrint('More options tapped!');
          onPressed();
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
    );
  }
}
