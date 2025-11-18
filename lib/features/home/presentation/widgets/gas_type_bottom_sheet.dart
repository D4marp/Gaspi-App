import 'package:flutter/material.dart';

class GasTypeBottomSheet extends StatefulWidget {
  final String? selectedGasType;
  final Function(String) onGasTypeSelected;

  const GasTypeBottomSheet({
    super.key,
    this.selectedGasType,
    required this.onGasTypeSelected,
  });

  @override
  State<GasTypeBottomSheet> createState() => _GasTypeBottomSheetState();
}

class _GasTypeBottomSheetState extends State<GasTypeBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<String> _gasTypes = [
    'Acetylene',
    'Oxygen',
    'Pure Argon',
    'Mix Gas',
    'CO2',
    'Nitrogen',
  ];

  List<String> get _filteredGasTypes {
    if (_searchQuery.isEmpty) {
      return _gasTypes;
    }
    return _gasTypes
        .where((gas) => gas.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      constraints: const BoxConstraints(
        maxHeight: 529,
      ),
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
          // Title
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 326,
                  child: Text(
                    'Gas Type',
                    style: TextStyle(
                      color: const Color(0xFF242424),
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
          const SizedBox(height: 32),
          // Search and List
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Field
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 0,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(100),
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
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.53),
                            ),
                          ),
                          child: const Icon(
                            Icons.search,
                            size: 16,
                            color: Color(0xCC777985),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            cursorColor: const Color(0xFF007EFF),
                            onChanged: (value) {
                              setState(() {
                                _searchQuery = value;
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: 'Search Gas Type',
                              hintStyle: TextStyle(
                                color: Color(0xCC777985),
                                fontSize: 14,
                                fontFamily: 'Nunito Sans',
                                fontWeight: FontWeight.w300,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: const TextStyle(
                              color: Color(0xFF242424),
                              fontSize: 14,
                              fontFamily: 'Nunito Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Gas Type List
                  ..._filteredGasTypes.map(
                    (gasType) => Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: InkWell(
                        onTap: () {
                          widget.onGasTypeSelected(gasType);
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          width: 326,
                          child: Text(
                            gasType,
                            style: TextStyle(
                              color: widget.selectedGasType == gasType
                                  ? const Color(0xFF1E3A8A)
                                  : const Color(0xFF677487),
                              fontSize: 16,
                              fontFamily: 'Nunito Sans',
                              fontWeight: widget.selectedGasType == gasType
                                  ? FontWeight.w700
                                  : FontWeight.w600,
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
          ),
        ],
      ),
    );
  }
}
