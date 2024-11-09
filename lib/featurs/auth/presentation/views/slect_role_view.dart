import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'widgets/User_role_contaner.dart';

class SlectRoleView extends StatelessWidget {
  const SlectRoleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainAppColor,
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(kAppLogo,height: 50,),
          ),
        ] ,
        title: const Text(
          'تصنيف المستخدم',
          style: Styles.textStyle18,
        ),
      ),
      body: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          UserRoleContaner(
            icon: Icons.person,
            roleName: 'مستخدم',
          ),
          UserRoleContaner(
            icon: Icons.store,
            roleName: 'صاحب محل',
          )
        ],
      ),
    );
  }
}


