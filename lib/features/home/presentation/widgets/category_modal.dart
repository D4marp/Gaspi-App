import 'package:flutter/material.dart';

class CategoryModal extends StatefulWidget {
  const CategoryModal({super.key});

  @override
  State<CategoryModal> createState() => _CategoryModalState();
}

class _CategoryModalState extends State<CategoryModal> {
  final categories = [
    'Acetylene',
    'Oxygen',
    'Pure Argon',
    'Mix Gas',
    'CO2',
    'Nitrogen',
  ];

  String selectedCategory = '';
  final searchController = TextEditingController();
  late List<String> filteredCategories;

  @override
  void initState() {
    super.initState();
    filteredCategories = categories;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterCategories(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCategories = categories;
      } else {
        filteredCategories = categories
            .where((cat) => cat.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
        spacing: 32,
        children: [
          // Header
          Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 24,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: const Text(
                    'Inventory Category',
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
              ],
            ),
          ),

          // Content
          Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 24,
              children: [
                // Search Field
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        width: 1.50,
                        color: Color(0xFFDCDBDB),
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 12,
                    children: [
                      const Icon(
                        Icons.search,
                        size: 16,
                        color: Color(0xCC777985),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          onChanged: _filterCategories,
                          decoration: const InputDecoration(
                            hintText: 'Search Product Category',
                            hintStyle: TextStyle(
                              color: Color(0xCC777985),
                              fontSize: 14,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w300,
                            ),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            color: Color(0xFF677487),
                            fontSize: 14,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Category List
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 24,
                    children: List.generate(
                      filteredCategories.length,
                      (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = filteredCategories[index];
                          });
                          Navigator.pop(context, filteredCategories[index]);
                        },
                        child: Text(
                          filteredCategories[index],
                          style: TextStyle(
                            color: selectedCategory == filteredCategories[index]
                                ? const Color(0xFF007EFF)
                                : const Color(0xFF677487),
                            fontSize: 16,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w600,
                            height: 1.40,
                            letterSpacing: -0.32,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
