import 'package:flutter/material.dart';

class BorderTextFiald extends StatelessWidget {
  const BorderTextFiald({
    super.key,
    required this.hintText,
    this.controller,  this.obscure=false,
  });
  final String? hintText;
  final TextEditingController? controller;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscure,
      controller: controller,
      validator: (data) {
        if (data!.isEmpty) {
          return 'value is required';
        }
        return null;
      },
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        border: const OutlineInputBorder(
          //borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
