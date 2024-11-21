import 'package:flutter/material.dart';

import '../../../../../Core/constats.dart';

class SparePartsSelector extends StatefulWidget {
  final void Function(String) onSelect;

  const SparePartsSelector({super.key, required this.onSelect});
  @override
  _SparePartsSelectorState createState() => _SparePartsSelectorState();
}

class _SparePartsSelectorState extends State<SparePartsSelector> {
  String? selectedPart;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Number of items per row
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10,
          childAspectRatio: 4 / 2, // Adjust for more or less width per item
        ),
        itemCount: kRepairableParts.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedPart = kRepairableParts[index];
              });
              widget.onSelect(selectedPart!);
            },
            child: Container(
              decoration: BoxDecoration(
                color: selectedPart == kRepairableParts[index]
                    ? Colors.blue.withOpacity(0.2)
                    : Colors.white,
                border: Border.all(
                  color: selectedPart == kRepairableParts[index]
                      ? Colors.blue
                      : Colors.grey,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  kRepairableParts[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: selectedPart == kRepairableParts[index]
                        ? Colors.blue
                        : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
