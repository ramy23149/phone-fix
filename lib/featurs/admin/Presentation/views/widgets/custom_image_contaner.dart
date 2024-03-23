import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageContaner extends StatefulWidget {
  const ImageContaner({super.key, this.onImageSelected});
  final void Function(File)? onImageSelected;


  @override
  State<ImageContaner> createState() => _ImageContanerState();
}

class _ImageContanerState extends State<ImageContaner> {
  File? image;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final imageFile = await _picker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      setState(() {
        image = File(imageFile.path);
      });
    } if(widget.onImageSelected != null){
      widget.onImageSelected!(image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          _pickImage();
        },
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
            child: image == null
                ? const Icon(Icons.camera_alt_outlined)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.file(
                      image!,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
