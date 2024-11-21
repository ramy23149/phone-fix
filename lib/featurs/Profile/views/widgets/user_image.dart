import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/servers/sherd_pref.dart';
import 'package:food_delivery_app/Core/widgets/custom_loadingIndecator.dart';
import 'package:food_delivery_app/featurs/home/Presentation/Manager/providers/customer_data_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../auth/data/enums/user_role_enum.dart';

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
      final customerData = context.read<CustomerDataProvider>();
      String phoneNumber = customerData.phoneNumber!;
      Reference ref =
          FirebaseStorage.instance.ref().child('images').child(phoneNumber);
      String collectoinName;
      final userRole = customerData.userRole;
      if (userRole == UserRoleEnum.storeOwner.getDisplayName) {
        collectoinName = UserRoleEnum.storeOwner.getCollectionName;
      } else {
        collectoinName = UserRoleEnum.user.getCollectionName;
      }
      UploadTask uploadTask = ref.putFile(image ?? File(''));

      var url = await (await uploadTask).ref.getDownloadURL();
      imageUrl = url;
      FirebaseFirestore.instance
          .collection(collectoinName)
          .doc(phoneNumber)
          .update({'image': url});
        await SherdPrefHelper().setImage(url);
      setState(() {});
    }
  }

  loadImage() async {
    imageUrl = context.read<CustomerDataProvider>().image;
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
            child: imageUrl != null && imageUrl != ''
                ? CachedNetworkImage(
                  imageUrl:   imageUrl!,
                  errorWidget: (context, url, error) {
                    return const Icon(
                      Icons.error,);
                  },
                  placeholder: (context, url) => const Center(
                child:   CustomLoadingIndecator()
                  ),
                    fit: BoxFit.fill,
                    height: 120,
                    width: 120,
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
