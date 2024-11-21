import 'package:flutter/material.dart';
import '../../../../../Core/text_styles/Styles.dart';
import '../../../../home/data/enums/accessories_enum.dart';
import '../../../../home/data/enums/spare_parts_enum.dart';

class DropdownCategory extends StatelessWidget {
  final bool isAccessoriesStore;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final bool? isNeedsToAddService;
  final List<String> dynamicItems; // Pass dynamic items

  const DropdownCategory({
    super.key,
    required this.isAccessoriesStore,
    required this.selectedValue,
    required this.onChanged,
    this.isNeedsToAddService,
    required this.dynamicItems, // Accept dynamic items
  });

  @override
  Widget build(BuildContext context) {
    final items = isAccessoriesStore
        ? AccessoriesEnum.values
            .where((element) => element != AccessoriesEnum.somethingElse)
            .map((e) => e.getDisplayName)
            .toList()
        : isNeedsToAddService!
            ? SparePartsBrandsEnum.values.map((e) => e.displayName).toList()
            : SparePartsEnum.values.where((element) => element != SparePartsEnum.someThingElse).map((e) => e.displayName).toList();

    final allItems = [...items, ...dynamicItems, "شيء اخر"];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('حدد الفئه', style: Styles.textStyle18),
        const SizedBox(height: 10),
        Container(
          color: const Color(0xffE8E8F7),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              menuMaxHeight: 250,
              isExpanded: true,
              value: selectedValue,
              items: allItems.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                    item == "شيء اخر"
                        ? "شيء اخر"
                        : item, // Display the item's name
                    style: Styles.textStyle14.copyWith(color: Colors.black),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
              hint: const Text('حدد الفئه'),
            ),
          ),
        ),
      ],
    );
  }
}
