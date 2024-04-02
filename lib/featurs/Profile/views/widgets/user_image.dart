import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImage extends StatefulWidget {
  const UserImage({super.key});

  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  File? image;

  String? imageUrl;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final imageFile = await _picker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      setState(() {
        image = File(imageFile.path);
      });
    }
    //  if(widget.onImageSelected != null){
    //   widget.onImageSelected!(image!);
    // }
  }

  upLoadImageToFireStore() async {
    if (image != null) {
      String address = FirebaseAuth.instance.currentUser!.uid;
      Reference ref =
          FirebaseStorage.instance.ref().child('images').child(address);

      UploadTask uploadTask = ref.putFile(image ?? File(''));

      var url = await (await uploadTask).ref.getDownloadURL();
      imageUrl = url;
      FirebaseFirestore.instance
          .collection('users')
          .doc(address)
          .update({'image': url});
      setState(() {});
    }
  }

  loadImage() async {
    String address = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(address)
        .get()
        .then((value) {
      imageUrl = value.data()!['image'];
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _pickImage().then((_) {
          if (image != null) {
            upLoadImageToFireStore();
          }
        });
      },
      child: Material(
        shape: const CircleBorder(),
        elevation: 6.0,
        child: CircleAvatar(
          radius: 60,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: imageUrl != null && imageUrl !=''
                ? Image.network(
                    imageUrl!,
                    fit: BoxFit.fill,
                    height: 120,
                    width: 120,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child; 
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ); 
                      }
                    },
                  )
                : Image.asset(
                    'assets/images/profile.jpg',
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    );
  }
}
