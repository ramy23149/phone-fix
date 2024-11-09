import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/app_router.dart';
import 'package:go_router/go_router.dart';
import 'custom_uper_container.dart';
import 'signUp_user_contanier_data.dart';
import 'user_state.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key});

  @override
  State<SignInViewBody> createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<SignInViewBody> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  GlobalKey<FormState> fromKey = GlobalKey();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          const CustomUperContainer(),
          UserState(
            question: 'Already have an account?',
            ansswer: 'LOGIN',
            onPressed: () {
              context.go(AppRouter.kLogInView);
            },
          ),
          // Positioned(
          //   right: 0,
          //   left: 0,
          //   top: 10,
          //   child: Image.asset(
          //     'assets/images/logo (2).png',
          //     width: MediaQuery.of(context).size.width * .7,
          //     height: 50,
          //   ),
          // ),
          Positioned(
            right: 20,
            left: 20,
            top: 100,
            bottom: 90,
            child: SignUpUserDataContaner(
                fromKey: fromKey,
                nameController: nameController,
                emailController: emailController,
                passwordController: passwordController),
          ),
        ],
      ),
    );
  }
}
