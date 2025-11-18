import 'package:flutter/material.dart';

/// Search Modal Widget - dapat ditampilkan saat search button di navigation ditekan
class SearchModal extends StatefulWidget {
  final Function(String)? onSearch;
  final VoidCallback? onCancel;

  const SearchModal({
    super.key,
    this.onSearch,
    this.onCancel,
  });

  @override
  State<SearchModal> createState() => _SearchModalState();
}

class _SearchModalState extends State<SearchModal> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearch() {
    if (_searchController.text.isNotEmpty) {
      final searchQuery = _searchController.text;
      widget.onSearch?.call(searchQuery);
      Navigator.pop(context);
    }
  }

  void _handleCancel() {
    _searchController.clear();
    widget.onCancel?.call();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        width: 320,
        padding: const EdgeInsets.all(18.55),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1.55,
              color: Color(0xFFEDEDED),
            ),
            borderRadius: BorderRadius.circular(12.37),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 15.46,
          children: [
            // Search Input Field
            Container(
              width: double.infinity,
              height: 38,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(64),
                border: Border.all(
                  width: 1,
                  color: const Color(0xFFE6E6E9),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x05000000),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8,
                children: [
                  const Icon(
                    Icons.search,
                    size: 18,
                    color: Color(0xFF9C9C9C),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      cursorColor: const Color(0xFF007EFF),
                      style: const TextStyle(
                        color: Color(0xFF353535),
                        fontSize: 12,
                        fontFamily: 'Nunito Sans',
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.12,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Search at Inventory',
                        hintStyle: TextStyle(
                          color: Color(0xFF9C9C9C),
                          fontSize: 12,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.12,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Action Buttons Row
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15.46,
              children: [
                // Search Button
                GestureDetector(
                  onTap: _handleSearch,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18.55, vertical: 6.18),
                    decoration: BoxDecoration(
                      color: const Color(0xFF007EFF),
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x26007EFF),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 8,
                      children: [
                        Text(
                          'Search',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w600,
                            height: 1.20,
                            letterSpacing: -0.40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Cancel Button - White with Border
                GestureDetector(
                  onTap: _handleCancel,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18.55, vertical: 6.18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(
                        width: 1.55,
                        color: const Color(0xFFEDEDED),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x05000000),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 8,
                      children: [
                        Text(
                          'Cancel',
                          style: TextStyle(
                            color: Color(0xFF353535),
                            fontSize: 20,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w600,
                            height: 1.20,
                            letterSpacing: -0.40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
