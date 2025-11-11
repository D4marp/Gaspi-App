import 'package:flutter/material.dart';

/// Bottom sheet showing asset options
class AssetOptionsBottomSheet extends StatelessWidget {
  const AssetOptionsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
              _AssetOption(
                title: 'Registered Cylinders',
                description: 'Check the information of your cylinder assets.',
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Navigate to cylinders page
                },
              ),
              const SizedBox(height: 24),

              // Registered Transport Racks
              _AssetOption(
                title: 'Registered Transport Racks',
                description: 'Check the information of your Transport Rack assets.',
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Navigate to transport racks page
                },
              ),
              const SizedBox(height: 24),

              // Registered Manifolds
              _AssetOption(
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
    );
  }
}

class _AssetOption extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const _AssetOption({
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
}
