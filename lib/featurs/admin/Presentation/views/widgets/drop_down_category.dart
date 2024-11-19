import 'package:flutter/material.dart';
import '../../../../../Core/text_styles/Styles.dart';
import '../../../../home/data/enums/accessories_enum.dart';
import '../../../../home/data/enums/spare_parts_enum.dart';

class DropdownCategory extends StatelessWidget {
  final bool isAccessoriesStore;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final bool? isNeedsToAddService;

  const DropdownCategory({
    super.key,
    required this.isAccessoriesStore,
    required this.selectedValue,
    required this.onChanged,
    this.isNeedsToAddService,
  });

  @override
  Widget build(BuildContext context) {
    final items = isAccessoriesStore
        ? AccessoriesEnum.values
        : isNeedsToAddService!
            ? SparePartsBrandsEnum
                .values
            : SparePartsEnum.values; //add more boolen when navigate to check if this store need to add product or add service

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select Category', style: Styles.textStyle18),
        const SizedBox(height: 10),
        Container(
          color: const Color(0xffE8E8F7),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              menuMaxHeight: 250,
              isExpanded: true,
              value: selectedValue,
              items: items.map((item) {
                return DropdownMenuItem(
                  value: item.name,
                  child: Text(
                    isAccessoriesStore
                        ? (item as AccessoriesEnum)
                            .getDisplayName // Correctly cast here
                        : isNeedsToAddService!
                            ? (item as SparePartsBrandsEnum).displayName
                            :(item as SparePartsEnum).displayName ,
                    style: Styles.textStyle14.copyWith(color: Colors.black),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
              hint: const Text('Select category'),
            ),
          ),
        ),
      ],
    );
  }
}
