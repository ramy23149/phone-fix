import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Core/app_router.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/Core/widgets/Costum_text_feld.dart';
import 'package:food_delivery_app/Core/widgets/custom_bottom.dart';
import 'package:food_delivery_app/Core/widgets/custom_loadingIndecator.dart';
import 'package:food_delivery_app/featurs/auth/presentation/manager/cubits/logIn_cubit/log_in_cubit.dart';
import 'package:food_delivery_app/featurs/auth/presentation/views/widgets/user_state.dart';
import 'package:go_router/go_router.dart';

import 'custom_uper_container.dart';

class LogInViewBody extends StatefulWidget {
  const LogInViewBody({super.key});

  @override
  State<LogInViewBody> createState() => _LogInViewBodyState();
}

class _LogInViewBodyState extends State<LogInViewBody> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          const CustomUperContainer(),
          UserState(
            question: 'Don\'t have an account?',
            ansswer: 'Sign up',
            onPressed: () {
              context.push(AppRouter.kSignUpView);
            },
          ),
          Positioned(
            right: 0,
            left: 0,
            top: 10,
            child: Image.asset(
              'assets/images/logo (2).png',
              width: MediaQuery.of(context).size.width * .7,
              height: 50,
            ),
          ),
          Positioned(
            right: 20,
            left: 20,
            top: 100,
            bottom: 100,
            child: Material(
              borderRadius: BorderRadius.circular(17),
              elevation: 5.0,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17), color: kWhite),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: BlocBuilder<LogInCubit, LogInState>(
                    builder: (context, state) {
                      return state is LogInLoading? const CustomLoadingIndecator() :Form(
                        key: key,
                        child: Column(
                          children: [
                            const Spacer(),
                            const Text(
                              'LogIn',
                              style: Styles.textStyle25,
                            ),
                            CustomTextField(
                              controller: emailController,
                              hint: 'Email',
                              icon: const Icon(Icons.email_outlined),
                            ),
                            const Spacer(),
                            CustomTextField(
                              controller: passwordController,
                              obscureText: true,
                              hint: 'Password',
                              icon: const Icon(Icons.password_outlined),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: GestureDetector(
                                onTap: () =>
                                    context.push(AppRouter.kPasswordRecavory),
                                child: const Text(
                                  'Forget password?',
                                  style: Styles.textStyle18,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                            const Spacer(
                              flex: 3,
                            ),
                            CustomBotton(
                              onPressed: () {
                                if (key.currentState!.validate()) {
                                  BlocProvider.of<LogInCubit>(context)
                                      .loginUser(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          context: context);
                                }
                              },
                              text: 'LOGIN',
                              backgroundColor: kRed,
                              textColor: kWhite,
                              borderRadius: BorderRadius.circular(90),
                            ),
                            const Spacer()
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
