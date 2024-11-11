import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';

class CustomTextButtom extends StatelessWidget {
  const CustomTextButtom({super.key, required this.text, required this.onPressed});
  final String text;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(5),
      //  margin: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: Styles.textStyle18.copyWith(color: Colors.black, decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}
