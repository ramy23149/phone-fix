import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Manager/providers/change_category_provider.dart';

class ProductCheckBox extends StatelessWidget {
  const ProductCheckBox({
    super.key,
    required this.categoryEnum,
  });

  final dynamic categoryEnum;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Listen to selected category and update the radio buttons accordingly
        Consumer<ChangeCategoryProvider>(
          builder: (_, ChangeCategoryProvider provider, __) => Checkbox(
            value: provider.selectedSparePartsSubCategorys.contains(categoryEnum),
            onChanged: (value) {
              // Call provider's method to select category
              provider.selectCategory(categoryEnum);
              
            },
          ),
        ),
        Text(categoryEnum),
      ],
    );
  }
}