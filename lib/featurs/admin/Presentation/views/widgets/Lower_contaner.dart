import 'package:flutter/material.dart';


class UperContainer extends StatelessWidget {
  const UperContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            height: MediaQuery.of(context).size.height *.6,
            width: MediaQuery.of(context).size.width,
            decoration:  const BoxDecoration(
              color: Color(0xffEAE9E8),
            ),
          );
  }
}