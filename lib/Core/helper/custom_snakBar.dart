  import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String massege) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        
        backgroundColor: Colors.indigo,
        content: Text(massege),
        duration: const Duration(seconds: 2),
      ),
    );
  }