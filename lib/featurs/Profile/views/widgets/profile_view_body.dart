import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/Core/widgets/custom_loadingIndecator.dart';
import 'package:food_delivery_app/featurs/Profile/views/widgets/curved_contaner.dart';
import 'package:food_delivery_app/featurs/Profile/views/widgets/user_image.dart';
import '../../../../Core/servers/sherd_pref.dart';
import 'custom_listile.dart';
import 'user_action.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  String? name, email;
  String uid = FirebaseAuth.instance.currentUser!.uid;

  getSherdPref() async {
    email = await SherdPrefHelper().getUserEmail();
    name = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      return value.data()!['name'];
    });
    setState(() {});
  }

  onLoad() async {
    await getSherdPref();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onLoad();
  }

  @override
  Widget build(BuildContext context) {
    if (name == null || email == null) {
      return const CustomLoadingIndecator(); // Show loading indicator until data is loaded
    }

    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              const CurvedContaner(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4.2 - 90,
              ),
              Column(
                children: [
                  UserInformatoin(
                      icon: const Icon(Icons.person),
                      title: 'Name',
                      subtitle: name!),
                  UserInformatoin(
                      icon: const Icon(Icons.person),
                      title: 'Email',
                      subtitle: email!),
                  const UserAction(
                    title: 'Terms and Conditions',
                    icon: Icon(Icons.verified_user),
                  ),
                  const UserAction(
                    title: 'Delete Account',
                    icon: Icon(Icons.delete),
                  ),
                  const UserAction(
                    title: 'Log Out',
                    icon: Icon(Icons.logout),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
              right: 0,
              left: 0,
              top: MediaQuery.of(context).size.height / 4.2 - 60,
              child: const UserImage()),
          Positioned(
            right: 0,
            left: 0,
            top: MediaQuery.of(context).size.height * 0.053,
            child: Center(
              child: Text(
                name!,
                style: Styles.textStyle20Extra.copyWith(color: kWhite),
              ),
            ),
          )
        ],
      ),
    );
  }
}
