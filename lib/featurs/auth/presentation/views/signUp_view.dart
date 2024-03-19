import 'package:flutter/material.dart';
import 'package:food_delivery_app/featurs/auth/presentation/views/widgets/signUp_view_body.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child:  Scaffold(
        body: SignInViewBody(),
      ),
    );
  }
}