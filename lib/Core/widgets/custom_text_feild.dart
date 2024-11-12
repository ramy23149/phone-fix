import 'package:flutter/material.dart';

import '../text_styles/Styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.onSaved,
    required this.hinttext,
    required this.textEditingController,
    this.obscureText,
    this.onChanged,
    this.validator,
    this.prefix,
    this.keyboardType,
    this.maxLength,
  });
  final void Function(String?)? onSaved;
  final String hinttext;
  final TextEditingController textEditingController;
  final bool? obscureText;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final Widget? prefix;
  final TextInputType? keyboardType;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLength: maxLength,
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'can\'t be empty';
              } else {
                return null;
              }
            },
        obscureText: obscureText ?? false,
        controller: textEditingController,
        textAlign: TextAlign.center,
        onSaved: onSaved,
        decoration: InputDecoration(
          counterText: '',
          prefix: prefix,
          labelText: hinttext,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle: Styles.textStyle14,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
