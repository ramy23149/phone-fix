import 'package:flutter/material.dart';

import '../../../../Core/text_styles/Styles.dart';

class CustomPriceText extends StatelessWidget {
  const CustomPriceText({
    super.key,
    required this.price,
  });

  final int price;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$price',
            style: Styles.textStyle16.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: ' EGP',
            style: Styles.textStyle14.copyWith(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
