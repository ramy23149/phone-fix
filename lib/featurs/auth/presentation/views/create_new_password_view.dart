import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/constats.dart';
import '../../data/models/update_passowrd_model.dart';
import '../manager/cubits/update_password_cubit/update_password_cubit.dart';
import 'widgets/create_new_password_view_body.dart';

class CreateNewPasswordView extends StatelessWidget {
  const CreateNewPasswordView({super.key, required this.updatePasswordModel});
  final UpdatePassowrdModel updatePasswordModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdatePasswordCubit(),
      child: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                kMainAppColor,
                Colors.red,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: CreateNewPasswordViewBody(
            updatePassowrdModel: updatePasswordModel,
          ),
        ),
      ),
    );
  }
}
