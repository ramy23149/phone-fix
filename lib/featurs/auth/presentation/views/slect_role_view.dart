import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import '../../data/enums/user_role_enum.dart';
import 'widgets/User_role_contaner.dart';

class SlectRoleView extends StatelessWidget {
  const SlectRoleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              kAppLogo,
              height: 50,
            ),
          ),
        ],
        title: const Text(
          'تصنيف المستخدم',
          style: Styles.textStyle18,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [kMainAppColor, Colors.red],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            UserRoleContaner(
              icon: Icons.person,
              role: UserRoleEnum.user,
            ),
            UserRoleContaner(
              icon: Icons.store,
              role: UserRoleEnum.storeOwner,
            )
          ],
        ),
      ),
    );
  }
}
