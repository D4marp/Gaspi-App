import 'package:flutter/material.dart';

class CapacityBottomSheet extends StatelessWidget {
  final String? selectedCapacity;
  final Function(String) onCapacitySelected;

  const CapacityBottomSheet({
    super.key,
    this.selectedCapacity,
    required this.onCapacitySelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> capacities = [
      '47 Litre',
      '40 Litre',
      '20 Litre',
    ];

    return Container(
      width: 390,
      constraints: const BoxConstraints(
        maxHeight: 326,
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
                    'Capacity',
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
          // Capacity List
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: capacities.map(
                (capacity) => Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: InkWell(
                    onTap: () {
                      onCapacitySelected(capacity);
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                      width: 326,
                      child: Text(
                        capacity,
                        style: TextStyle(
                          color: selectedCapacity == capacity
                              ? const Color(0xFF1E3A8A)
                              : const Color(0xFF677487),
                          fontSize: 16,
                          fontFamily: 'Nunito Sans',
                          fontWeight: selectedCapacity == capacity
                              ? FontWeight.w700
                              : FontWeight.w600,
                          height: 1.40,
                          letterSpacing: -0.32,
                        ),
                      ),
                    ),
                  ),
                ),
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
