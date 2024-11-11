import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/featurs/auth/presentation/manager/cubits/ceck_user_existeince_cubit/ceck_user_existeince_cubit.dart';
import 'package:food_delivery_app/featurs/auth/presentation/views/widgets/signUp_view_body.dart';
import 'package:go_router/go_router.dart';

import '../../../../Core/app_router.dart';
import 'widgets/user_state_question.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckUserExisteniceCubit(),
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
