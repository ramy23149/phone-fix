import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Core/constats.dart';

import '../../helper/not_exist_user_dialog.dart';
import '../../manager/cubits/ceck_user_existeince_cubit/ceck_user_existeince_cubit.dart';
import 'custom_uper_container.dart';
import 'log_in_contanier.dart';

class LogInViewBody extends StatefulWidget {
  const LogInViewBody({super.key});

  @override
  State<LogInViewBody> createState() => _LogInViewBodyState();
}

class _LogInViewBodyState extends State<LogInViewBody> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckUserExisteniceCubit, CheckUserExisteniceState>(
      listener: (context, state) {
        if (state is ThisIsNewUser) {
          showNotExistUserDialog(
           context: context,
           message: "يبدو ان 0${state.phone} لم يقم بتسجيل الدخول قم بانشاء حساب الان");
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          const CustomUperContainer(),
          Positioned(
            top: 240,
            child: Container(
              height: 30,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  color: kWhite),
            ),
          ),
          Positioned(
            right: 20,
            left: 20,
            top: 100,
            bottom: 50,
            child: LogInContanier(
                passwordController: passwordController,
                formKey: formKey,
                phoneController: phoneController),
          ),
        ],
      ),
    );
  }
}
