import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              message:
                  "يبدو ان 0${state.phone} لم يقم بتسجيل الدخول قم بانشاء حساب الان");
        }
      },
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            fit: StackFit.expand,
            children: [
              const CustomUperContainer(),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9, // نسبة من العرض
                  height:
                      MediaQuery.of(context).size.height * 0.5, // نسبة من الارتفاع
                  child: LogInContanier(
                    passwordController: passwordController,
                    formKey: formKey,
                    phoneController: phoneController,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
