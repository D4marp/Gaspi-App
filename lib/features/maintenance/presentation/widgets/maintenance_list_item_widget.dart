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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cylinder $id',
                        style: TextStyle(
                          color: const Color(0xFF101828),
                          fontSize: sw(16),
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (subtitle != null) ...[
                        SizedBox(height: sh(4)),
                        Flexible(
                          child: Text(
                            subtitle!,
                            style: TextStyle(
                              color: const Color(0xFF999999),
                              fontSize: sw(12),
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(width: sw(12)),
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: sw(12),
                      vertical: sh(6),
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: statusColor, width: 1),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: sw(11),
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: sh(12)),
            Text(
              dateTime,
              style: TextStyle(
                color: const Color(0xFF999999),
                fontSize: sw(11),
                fontFamily: 'Nunito Sans',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
