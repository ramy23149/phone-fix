import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/featurs/auth/presentation/manager/cubits/logIn_cubit/log_in_cubit.dart';

import 'widgets/logIn_view_body.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogInCubit(),
      child: const SafeArea(
          child: Scaffold(
        body: LogInViewBody(),
      )),
    );
  }
}
