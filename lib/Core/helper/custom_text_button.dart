import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
const  CustomTextButton({
    super.key,
    required this.onPressed,
    required this.text, this.textStyle,
  });
  final void Function()?  onPressed;
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text,style: textStyle ?? const TextStyle(fontSize: 15,
      decoration: TextDecoration.underline),),
    );
  }
}
