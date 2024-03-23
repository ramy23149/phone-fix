import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery_app/Core/widgets/Custom_text_bottom.dart';
import 'package:go_router/go_router.dart';

import '../../../../../Core/text_styles/Styles.dart';

class AdminAppbar extends StatelessWidget {
  const AdminAppbar({super.key, required this.onPressed});
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Transform.translate(
        offset: const Offset(0, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () => context.pop(),
                child: const Icon(Icons.arrow_back_ios)),
            
            const Text(
              'Add Item',
              style: Styles.textStyle25,
              //textAlign: TextAlign.center,
            ),
          TextButton(onPressed: onPressed, child: const Text('Done',style: TextStyle(fontSize: 17),))
          ],
        ),
      ),
    );
  }
}
