import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/featurs/auth/presentation/manager/cubits/ceck_user_existeince_cubit/ceck_user_existeince_cubit.dart';
import 'package:food_delivery_app/featurs/auth/presentation/manager/cubits/check_password_cubit/check_password_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../../../Core/app_router.dart';
import 'widgets/logIn_view_body.dart';
import 'widgets/user_state_question.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CheckUserExisteniceCubit(),
        ),
        BlocProvider(
          create: (context) => CheckPasswordCubit(),
        ),
      ],
      child: Scaffold(
              backgroundColor: kWhite,
              body: const LogInViewBody(),
              bottomNavigationBar: UserStateQuestion(
      question: 'ليس لديك حساب؟',
      ansswer: 'انشاء حساب',
      onPressed: () {
        context.push(AppRouter.kSelectRoleView);
      },
              ),
            ),
    );
  }
}
