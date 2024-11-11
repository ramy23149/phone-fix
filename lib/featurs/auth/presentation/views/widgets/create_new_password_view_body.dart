import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Core/app_router.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/Core/helper/Costom_alert_dialog.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/Core/widgets/custom_text_feild.dart';
import 'package:food_delivery_app/featurs/auth/presentation/manager/cubits/update_password_cubit/update_password_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../Core/widgets/custom_bottom.dart';
import '../../../data/models/update_passowrd_model.dart';

class CreateNewPasswordViewBody extends StatefulWidget {
  const CreateNewPasswordViewBody({super.key, required this.updatePassowrdModel});

  final UpdatePassowrdModel updatePassowrdModel;
  @override
  State<CreateNewPasswordViewBody> createState() =>
      _CreateNewPasswordViewBodyState();
}

class _CreateNewPasswordViewBodyState extends State<CreateNewPasswordViewBody> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdatePasswordCubit, UpdatePasswordState>(
      listener: (context, state) {
        if(state is UpdatePasswordSuccess){
          context.go(AppRouter.kBottomNavBar);
        }else if (state is UpdatePasswordError) {
          showAlertDialog(context, state.error, const Icon(Icons.error), Colors.red);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is UpdatePasswordLoading,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(kAppLogo, height: 200, width: 200),
                  const SizedBox(height: 20),
                  const Text("اعاده تعيين كلمه المرور",
                      style: Styles.textStyle20Extra),
                  const SizedBox(height: 20),
                  CustomTextField(
                    hinttext: 'كلمه سر جديده',
                    textEditingController: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "من فضلك ادخل كلمه سر";
                      } else if (value.length < 6) {
                        return "كلمه السر يجب ان تكون اكثر من 6 حروف";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomTextField(
                    hinttext: 'تاكيد كلمه السر',
                    textEditingController: confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "من فضلك ادخل كلمه سر";
                      } else if (value.length < 6) {
                        return "كلمه السر يجب ان تكون اكثر من 6 حروف";
                      } else if (value != passwordController.text) {
                        return "كلمه السر غير متطابقه";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                      height: 20),
                  CustomBotton(
                    text: 'تاكيد',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<UpdatePasswordCubit>().updatePassword(
                            phoneNumber: widget.updatePassowrdModel.phoneNumber,
                            userRole: widget.updatePassowrdModel.userRole,
                            password: passwordController.text);
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
