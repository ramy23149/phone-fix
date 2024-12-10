import 'package:flutter/material.dart';

import '../../../../../Core/constats.dart';

class CustomUperContainer extends StatelessWidget {
  const CustomUperContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            //height: MediaQuery.of(context).size.height / 2.4,
            width: MediaQuery.of(context).size.width,
          margin:  EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 2.4,),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomLeft,
                colors: [kMainAppColor, Color(0xffF84A1E)],
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
              height: 30,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  color: kWhite),
                        ),
            ),
          );
  }
}