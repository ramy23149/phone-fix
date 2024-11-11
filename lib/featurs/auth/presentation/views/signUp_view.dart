import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/featurs/auth/presentation/views/widgets/signUp_view_body.dart';
import 'package:go_router/go_router.dart';

import '../../../../Core/app_router.dart';
import '../manager/cubits/phone_auth_cubit/phone_auth_cubit.dart';
import 'widgets/user_state_question.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneAuthCubit(),
      child:  SafeArea(
        child: Scaffold(
          backgroundColor: kWhite,
          body:const SignInViewBody(),
          bottomNavigationBar: UserStateQuestion(
            question: 'Already have an account?',
            ansswer: 'LOGIN',
            onPressed: () {
              context.go(AppRouter.kLogInView);
            },
          ),
        ),
      ),
    );
  }
}
