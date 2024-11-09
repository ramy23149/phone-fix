import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/Core/widgets/custom_bottom.dart';
import 'package:food_delivery_app/Core/widgets/custom_loadingIndecator.dart';
import 'package:go_router/go_router.dart';
import '../../../../../Core/app_router.dart';
import '../../../../../Core/widgets/custom_text_feild.dart';
import '../../manager/cubits/logIn_cubit/log_in_cubit.dart';

class LogInContanier extends StatelessWidget {
  const LogInContanier({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
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
          child: BlocBuilder<LogInCubit, LogInState>(
            builder: (context, state) {
              return state is LogInLoading
                  ? const CustomLoadingIndecator()
                  : SingleChildScrollView(
                    child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                          const SizedBox(height: 10,),
                            const Text(
                              'تسجيل الدخول',
                              style: Styles.textStyle25,
                            ),
                            const SizedBox(height: 20,),
                            CustomTextField(
                              textEditingController: emailController,
                              hinttext: 'Email',
                              //icon: const Icon(Icons.email_outlined),
                            ),
                            const SizedBox(height: 15,),
                            CustomTextField(
                              textEditingController: passwordController,
                              obscureText: true,
                              hinttext: 'Password',
                            //  icon: const Icon(Icons.password_outlined),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: GestureDetector(
                                onTap: () => context
                                    .push(AppRouter.kPasswordRecavory),
                                child: const Text(
                                  'Forget password?',
                                  style: Styles.textStyle18,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            CustomBotton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  BlocProvider.of<LogInCubit>(context)
                                      .loginUser(
                                          email: emailController.text,
                                          password:
                                              passwordController.text,
                                          context: context);
                                }
                              },
                              text: 'LOGIN',
                              backgroundColor: kMainAppColor,
                              textColor: kWhite,
                              borderRadius: BorderRadius.circular(90),
                            ),
                            const SizedBox(height: 10,),
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
