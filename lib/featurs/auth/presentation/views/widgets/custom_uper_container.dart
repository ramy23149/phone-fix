import 'package:flutter/material.dart';

import '../../../../../Core/constats.dart';

class CustomUperContainer extends StatelessWidget {
  const CustomUperContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            height: MediaQuery.of(context).size.height / 2.6,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                colors: [kRed, Color(0xffF84A1E)],
              ),
            ),
          );
  }
}