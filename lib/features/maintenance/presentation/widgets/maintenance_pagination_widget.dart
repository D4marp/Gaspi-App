import 'package:flutter/material.dart';

/// Reusable pagination controls widget
class MaintenancePaginationWidget extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;

  const MaintenancePaginationWidget({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double sw(double px) => px / 390 * screenWidth;
    double sh(double px) => px / 844 * screenHeight;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: sw(20), vertical: sh(16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Previous button
            GestureDetector(
              onTap: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: sw(16), vertical: sh(10)),
                decoration: BoxDecoration(
                  color: currentPage > 1 ? Colors.white : const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: currentPage > 1 ? const Color(0xFFEDEDED) : const Color(0xFFDDDDDD),
                    width: 1,
                  ),
                ),
                child: Text(
                  'Previous',
                  style: TextStyle(
                    color: currentPage > 1 ? const Color(0xFF101828) : const Color(0xFF999999),
                    fontSize: sw(12),
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(width: sw(12)),

            // Page numbers (limited to show max 5 pages)
            ...List.generate(
              totalPages > 5 ? 5 : totalPages,
              (index) {
                int pageNum;
                if (totalPages > 5) {
                  if (currentPage <= 3) {
                    pageNum = index + 1;
                  } else if (currentPage >= totalPages - 2) {
                    pageNum = totalPages - 4 + index;
                  } else {
                    pageNum = currentPage - 2 + index;
                  }
                } else {
                  pageNum = index + 1;
                }

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: sw(4)),
                  child: GestureDetector(
                    onTap: () => onPageChanged(pageNum),
                    child: Container(
                      width: sw(32),
                      height: sh(32),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: currentPage == pageNum
                            ? const Color(0xFF007EFF)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: currentPage == pageNum
                              ? const Color(0xFF007EFF)
                              : const Color(0xFFEDEDED),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        '$pageNum',
                        style: TextStyle(
                          color: currentPage == pageNum
                              ? Colors.white
                              : const Color(0xFF101828),
                          fontSize: sw(12),
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(width: sw(12)),

            // Next button
            GestureDetector(
              onTap: currentPage < totalPages ? () => onPageChanged(currentPage + 1) : null,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: sw(16), vertical: sh(10)),
                decoration: BoxDecoration(
                  color: currentPage < totalPages ? Colors.white : const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: currentPage < totalPages ? const Color(0xFFEDEDED) : const Color(0xFFDDDDDD),
                    width: 1,
                  ),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(
                    color: currentPage < totalPages ? const Color(0xFF101828) : const Color(0xFF999999),
                    fontSize: sw(12),
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
