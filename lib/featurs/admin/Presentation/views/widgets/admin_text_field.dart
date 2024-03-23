import 'package:flutter/material.dart';

class AdminTextField extends StatelessWidget {
  const AdminTextField({super.key, required this.hint, this.maxlines});
  final String hint;
  final int? maxlines;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
    validator: (value) {
      if (value!.isEmpty) {
        return 'Field is required';
      }
      return null;
    },
      maxLines: maxlines,
      decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: const Color(0xffE8E8F7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          
            contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        
    );
  }
}
