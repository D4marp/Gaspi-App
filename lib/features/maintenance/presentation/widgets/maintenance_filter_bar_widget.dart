import 'package:flutter/material.dart';

/// Reusable filter and search bar widget
class MaintenanceFilterBarWidget extends StatelessWidget {
  final String searchHint;
  final TextEditingController searchController;
  final Function(String) onSearchChanged;
  final List<String> filterOptions;
  final String? selectedFilter;
  final Function(String?) onFilterChanged;

  const MaintenanceFilterBarWidget({
    super.key,
    this.searchHint = 'Search Cylinder',
    required this.searchController,
    required this.onSearchChanged,
    required this.filterOptions,
    this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double sw(double px) => px / 390 * screenWidth;
    double sh(double px) => px / 844 * screenHeight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search bar
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: sw(16),
            vertical: sh(12),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFF0F0F0), width: 1),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0A000000),
                blurRadius: 6,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: Color(0xFF999999)),
              SizedBox(width: sw(12)),
              Expanded(
                child: TextField(
                  controller: searchController,
                  onChanged: onSearchChanged,
                  decoration: InputDecoration(
                    hintText: searchHint,
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      color: const Color(0xFFC0C0C0),
                      fontSize: sw(14),
                      fontFamily: 'Nunito Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  style: TextStyle(
                    color: const Color(0xFF101828),
                    fontSize: sw(14),
                    fontFamily: 'Nunito Sans',
                    fontWeight: FontWeight.w400,
                  ),
                  cursorColor: const Color(0xFF007EFF),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: sh(16)),

        // Filter dropdown
        if (filterOptions.isNotEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: sw(16),
              vertical: sh(12),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFF0F0F0), width: 1),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 6,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedFilter,
              hint: Text(
                'Select Filter',
                style: TextStyle(
                  color: const Color(0xFFC0C0C0),
                  fontSize: sw(14),
                  fontFamily: 'Nunito Sans',
                ),
              ),
              underline: const SizedBox(),
              items: [
                DropdownMenuItem<String>(
                  value: null,
                  child: Text('All'),
                ),
                ...filterOptions.map((option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
              ],
              onChanged: onFilterChanged,
            ),
          ),
      ],
    );
  }
}
