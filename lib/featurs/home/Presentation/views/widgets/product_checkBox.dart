import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Manager/providers/change_category_provider.dart';

class ProductCheckBox extends StatefulWidget {
  const ProductCheckBox({
    super.key,
    required this.categoryEnum,
  });

  final dynamic categoryEnum;

  @override
  State<ProductCheckBox> createState() => _ProductCheckBoxState();
}

class _ProductCheckBoxState extends State<ProductCheckBox> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChangeCategoryProvider>(context);
    return Row(
      children: [
        // Listen to selected category and update the radio buttons accordingly
        Checkbox(
          value: provider.selectedSparePartsSubCategorys.contains(widget.categoryEnum),
          onChanged: (value) {
            provider.selectCategory(widget.categoryEnum);
            setState(() {});
          },
        ),
        Text(widget.categoryEnum),
      ],
    );
  }
}