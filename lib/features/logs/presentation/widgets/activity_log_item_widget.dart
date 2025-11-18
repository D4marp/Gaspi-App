import 'package:flutter/material.dart';

/// Reusable log item widget for displaying activity log entries
class ActivityLogItemWidget extends StatelessWidget {
  final String action;
  final String userName;
  final String dateTime;
  final VoidCallback? onTap;

  const ActivityLogItemWidget({
    super.key,
    required this.action,
    required this.userName,
    required this.dateTime,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double sw(double px) => px / 390 * screenWidth;
    double sh(double px) => px / 844 * screenHeight;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: sw(20),
          vertical: sh(16),
        ),
        margin: EdgeInsets.only(bottom: sh(12)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFEDEDED), width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                action,
                style: TextStyle(
                  color: const Color(0xFF353535),
                  fontSize: sw(14),
                  fontFamily: 'Nunito Sans',
                  fontWeight: FontWeight.w600,
                  height: 1.40,
                  letterSpacing: -0.28,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            SizedBox(height: sh(8)),
            Text(
              '$userName - $dateTime',
              style: TextStyle(
                color: const Color(0xFF677487),
                fontSize: sw(14),
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w400,
                height: 1.40,
                letterSpacing: -0.28,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
