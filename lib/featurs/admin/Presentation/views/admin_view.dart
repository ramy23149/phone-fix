import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/featurs/auth/presentation/manager/cubits/check_password_cubit/check_password_cubit.dart';

import 'widgets/AdminView_body.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckPasswordCubit(),
      child: const Scaffold(
        body: AdminViewBody(),
      ),
    );
  }
}
