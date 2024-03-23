import 'package:flutter/material.dart';

class ImageContaner extends StatelessWidget {
  const ImageContaner({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
         child: Material(
          borderRadius: BorderRadius.circular(16),
          elevation: 5,
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(width: 2, color: Colors.black),
            ),
            child: const Icon(Icons.camera_alt_outlined,),
          ),
         ),
       );
  }
}