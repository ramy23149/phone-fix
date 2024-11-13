import 'package:flutter/material.dart';

import 'custom_type_item.dart';

class TypeSection extends StatelessWidget {
  const TypeSection({super.key});


  @override
  Widget build(BuildContext context) {
    return const Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTypeItem(
                  keyIdentefair: 0,
                ),
                CustomTypeItem(
                  keyIdentefair: 1,
                ),
                CustomTypeItem(
                  keyIdentefair: 2,                
                ),
                CustomTypeItem(
                  keyIdentefair: 3,
                ),
              ],
            ),
          );
  }
}