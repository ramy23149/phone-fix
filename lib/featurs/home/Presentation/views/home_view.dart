import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/servers/sherd_pref.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/featurs/home/Presentation/views/home_view_body.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String? userName;

  Future<void> fetchUserName() async {
    String uId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((docs) {
      return docs.data()!['name'];
    }).then((value) {
      setState(() {
        userName = value;
      });
      SherdPrefHelper().setUserName(userName);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserName();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(userName != null ? 'Hallo $userName,' : 'loading...',
              style: Styles.textStyle20),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
              child: IconButton(
                iconSize: 27,
                icon: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        body: HomeViewBody(),
      ),
    );
  }
}
