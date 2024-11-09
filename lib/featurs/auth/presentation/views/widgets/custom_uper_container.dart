import 'package:flutter/material.dart';

import '../../../../../Core/constats.dart';

class CustomUperContainer extends StatelessWidget {
  const CustomUperContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
                height: MediaQuery.of(context).size.height / 2.4,
                width: MediaQuery.of(context).size.width,
              //margin: const EdgeInsets.only(bottom: 18),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                    colors: [kMainAppColor, Color(0xffF84A1E)],
                  ),
                ),
              ),
        
        
      ],
    );
  }
}