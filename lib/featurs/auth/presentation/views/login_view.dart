import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/featurs/auth/presentation/manager/cubits/logIn_cubit/log_in_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../../../Core/app_router.dart';
import 'widgets/logIn_view_body.dart';
import 'widgets/user_state_question.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogInCubit(),
      child:  SafeArea(
          child: Scaffold(
            backgroundColor: kWhite,
        body:const LogInViewBody(),
        bottomNavigationBar:   UserStateQuestion(
              question: 'Don\'t have an account?',
              ansswer: 'Sign up',
              onPressed: () {
                context.push(AppRouter.kSelectRoleView);
              },
            ),
      )),
    );
  }
}
