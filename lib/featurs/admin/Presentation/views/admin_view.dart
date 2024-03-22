import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/featurs/admin/Presentation/manager/cubits/admin_cubit/admin_cubit.dart';

import 'widgets/AdminView_body.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminCubit(),
      child: const SafeArea(
        child: Scaffold(
          body: AdminViewBody(),
        ),
      ),
    );
  }
}
