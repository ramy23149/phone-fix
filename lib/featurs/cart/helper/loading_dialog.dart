
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    barrierColor: kMainAppColor,
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10,),
            Text("...جاري معالجه طلبك",style: Styles.textStyle16,),
          ],
        ),
      );
    },
  );
}