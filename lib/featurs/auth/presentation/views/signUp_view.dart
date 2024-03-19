import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/featurs/auth/presentation/views/widgets/signUp_view_body.dart';

import '../manager/cubits/signUp_cubit/sign_up_cubit.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: const SafeArea(
        child: Scaffold(
          body: SignInViewBody(),
        ),
      ),
    );
  }
}
