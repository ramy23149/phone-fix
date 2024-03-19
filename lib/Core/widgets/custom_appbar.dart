import 'package:flutter/material.dart';

import '../text_styles/Styles.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
          height: 50,
          width: double.infinity,
           child: Material(
            elevation: 2,
            child: Transform.translate(
              offset: const Offset(0, 8),
              child: const Text('Wallet',style: Styles.textStyle25,textAlign: TextAlign.center,))),
         );
  }
}