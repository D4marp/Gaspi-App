import 'package:flutter/material.dart';

class PackageModal extends StatefulWidget {
  const PackageModal({super.key});

  @override
  State<PackageModal> createState() => _PackageModalState();
}

class _PackageModalState extends State<PackageModal> {
  final packages = [
    'Cylinder',
    'Transport Rack 6',
    'Transport Rack 9',
    'Transport Rack 12',
    'Transport Rack 16',
    'Manifold 6',
    'Manifold 9',
    'Manifold 12',
    'Manifold 16',
  ];

  String selectedPackage = '';
  final searchController = TextEditingController();
  late List<String> filteredPackages;

  @override
  void initState() {
    super.initState();
    filteredPackages = packages;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _filterPackages(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredPackages = packages;
      } else {
        filteredPackages = packages
            .where((pkg) => pkg.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 24,
          children: [
            // Header
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 16,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: const Text(
                      'Package',
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
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  // Search Field
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 0,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x0A000000),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                          spreadRadius: 0,
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
                          size: 16,
                          color: Color(0xFF677487),
                        ),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            cursorColor: const Color(0xFF007EFF),
                            onChanged: _filterPackages,
                            decoration: const InputDecoration(
                              hintText: 'Search Package',
                              hintStyle: TextStyle(
                                color: Color(0xFF9C9C9C),
                                fontSize: 14,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: const TextStyle(
                              color: Color(0xFF101828),
                              fontSize: 14,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Package List
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.4,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 16,
                        children: List.generate(
                          filteredPackages.length,
                          (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedPackage = filteredPackages[index];
                              });
                              Navigator.pop(context, filteredPackages[index]);
                            },
                            child: Text(
                              filteredPackages[index],
                              style: TextStyle(
                                color: selectedPackage == filteredPackages[index]
                                    ? const Color(0xFF007EFF)
                                    : const Color(0xFF677487),
                                fontSize: 14,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w600,
                                height: 1.40,
                                letterSpacing: -0.28,
                              ),
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
      ),
    );
  }
}
