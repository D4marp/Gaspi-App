import 'package:flutter/material.dart';

/// Reusable item widget for displaying maintenance list items
class MaintenanceListItemWidget extends StatelessWidget {
  final String id;
  final String status;
  final Color statusColor;
  final String dateTime;
  final String? subtitle; // Additional info like registered company
  final VoidCallback? onTap;

  const MaintenanceListItemWidget({
    super.key,
    required this.id,
    required this.status,
    required this.statusColor,
    required this.dateTime,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    double sh(double px) => px / 844 * screenHeight;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.only(bottom: sh(12)),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  id,
                  style: const TextStyle(
                    color: Color(0xFF353535),
                    fontSize: 14,
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w600,
                    height: 1.40,
                    letterSpacing: -0.28,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 1,
                        color: statusColor,
                      ),
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w600,
                      height: 1.40,
                      letterSpacing: -0.24,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              dateTime,
              style: const TextStyle(
                color: Color(0xFF677487),
                fontSize: 14,
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w400,
                height: 1.40,
                letterSpacing: -0.28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
