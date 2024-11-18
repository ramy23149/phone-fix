import 'package:flutter/material.dart';

import 'custom_bottom_sheet_body.dart';
import 'custom_type_item.dart';

class TypeSection extends StatelessWidget {
  const TypeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CustomTypeItem(
            keyIdentefair: 0,
          ),
          const CustomTypeItem(
            keyIdentefair: 1,
          ),
          const CustomTypeItem(
            keyIdentefair: 2,
          ),
          CustomTypeItem(
            keyIdentefair: 3,
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const FilterBottomsheetBody();
                  });
            },
          ),
        ],
      ),
    );
  }
}
