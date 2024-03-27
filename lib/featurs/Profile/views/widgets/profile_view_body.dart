import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/featurs/Profile/views/widgets/curved_contaner.dart';
import 'package:food_delivery_app/featurs/Profile/views/widgets/user_image.dart';
import 'custom_listile.dart';
import 'user_action.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              const CurvedContaner(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4.2 - 90,
              ),
              const Column(
                children: [
                  UserInfo(
                    title: 'Name',
                    subtitle: 'Ramy Hany',
                    icon: Icon(Icons.person),
                  ),
                  UserInfo(
                    title: 'Email',
                    subtitle: 'RamyHany@gmail.com',
                    icon: Icon(Icons.email),
                  ),
                  UserAction(
                    title: 'Terms and Conditions',
                    icon: Icon(Icons.verified_user),
                  ),
                  UserAction(
                    title: 'Delete Account',
                    icon: Icon(Icons.delete),
                  ),
                  UserAction(
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
            child: const UserImage()
          ),
          Positioned(
            right: 0,
            left: 0,
            top: MediaQuery.of(context).size.height*0.053, 
            child: Center(
              child: Text('Ramy Hany',style: Styles.textStyle20Extra.copyWith(color: kWhite),),
            ),
          )
        ],
      ),
    );
  }
}

