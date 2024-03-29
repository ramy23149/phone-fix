import 'package:flutter/material.dart';

import '../text_styles/Styles.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Material(
        elevation: 2,
        child: Transform.translate(
          offset: const Offset(0, 8),
          child:  Text(
            title,
            style: Styles.textStyle25,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
