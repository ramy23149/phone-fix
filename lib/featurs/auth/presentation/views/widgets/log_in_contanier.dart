import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Core/app_router.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/Core/widgets/custom_bottom.dart';
import 'package:food_delivery_app/Core/widgets/custom_loadingIndecator.dart';
import 'package:food_delivery_app/featurs/auth/data/models/verificatoin_data_model.dart';
import 'package:go_router/go_router.dart';
import '../../../../../Core/functions/validate_the_egyption_phone_number.dart';
import '../../../../../Core/widgets/custom_text_feild.dart';
import '../../manager/cubits/ceck_user_existeince_cubit/ceck_user_existeince_cubit.dart';

class LogInContanier extends StatelessWidget {
  const LogInContanier({
    super.key,
    required this.formKey,
    required this.phoneController, required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(17),
      elevation: 5.0,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17), color: kWhite),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child:
              BlocConsumer<CheckUserExisteniceCubit, CheckUserExisteniceState>(
            listener: (context, state) {
              if (state is ThisUserAllreadyExist) {
                context.push(AppRouter.kVerifyView,
                    extra: VerificatoinDataModel(
                        data: null,
                        isForgotPasswordCase: false,
                        phone: phoneController.text,
                        isNew: false));
              }
            },
            builder: (context, state) {
              return state is CheckUserExisteniceLoading
                  ? const CustomLoadingIndecator()
                  : SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'تسجيل الدخول',
                              style: Styles.textStyle25,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomTextField(
                              textEditingController: phoneController,
                              hinttext: 'رقم الهاتف',
                              prefix: const Text(
                                "🇪🇬 +20",
                              ),
                              keyboardType: TextInputType.phone,
                              maxLength: 10,
                              validator: (value) {
                                final errorMessage =
                                    validateEgyptianPhoneNumber(value);

                                if (errorMessage != null) {
                                  return errorMessage;
                                }

                                if (state is ThisIsNewUser) {
                                  return 'هذا الحساب غير موجود ! ابدا بانشاء حسابك الان';
                                }

                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 13,
                            ),
                            CustomTextField(
                              hinttext: 'كلمه المرور',
                              textEditingController: passwordController,
                              obscureText: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  context.push(AppRouter.kPasswordRecavory);
                                },
                                child: const Text("هل نسيت كلمه المرور؟",style: Styles.textStyle16,),
                              )
                            ),
                            const SizedBox(height: 7,),
                            CustomBotton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  context
                                      .read<CheckUserExisteniceCubit>()
                                      .checkUserExistence(
                                          phone: phoneController.text);
                                }
                              },
                              text: 'تسجيل الدخول',
                              backgroundColor: kMainAppColor,
                              textColor: kWhite,
                              borderRadius: BorderRadius.circular(90),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
