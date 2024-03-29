import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Core/app_router.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/Core/helper/custom_snakBar.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/Core/widgets/Costum_text_feld.dart';
import 'package:food_delivery_app/Core/widgets/custom_bottom.dart';
import 'package:food_delivery_app/Core/widgets/custom_loadingIndecator.dart';
import 'package:food_delivery_app/featurs/auth/presentation/manager/cubits/signUp_cubit/sign_up_cubit.dart';
import 'package:go_router/go_router.dart';
import 'custom_uper_container.dart';
import 'user_state.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key});

  @override
  State<SignInViewBody> createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<SignInViewBody> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();

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
            question: 'Already have an account?',
            ansswer: 'LOGIN',
            onPressed: () {
              context.go(AppRouter.kLogInView);
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
            bottom: 90,
            child: Material(
              borderRadius: BorderRadius.circular(17),
              elevation: 5.0,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17), color: kWhite),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: BlocConsumer<SignUpCubit, SignUpState>(
                    listener: (context, state) {
                      if (state is SignUpSuccess) {
                        //showSnackBar(context, 'Account successfully created,login now');
                        context.go(AppRouter.kBottomNavBar);
                        showSnackBar(context, 'Welcome');
                      }
                    },
                    builder: (context, state) {
                      return state is SignUpLoading
                          ? const CustomLoadingIndecator()
                          : Form(
                              key: key,
                              child: Column(
                                children: [
                                  const Spacer(),
                                  const Text(
                                    'Sign up',
                                    style: Styles.textStyle25,
                                  ),
                                  const Spacer(),
                                   CustomTextField(
                                    controller: nameController,
                                    hint: 'Name',
                                    icon: const Icon(Icons.person_outline),
                                  ),
                                  const Spacer(),
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
                                  const Spacer(
                                    flex: 4,
                                  ),
                                  CustomBotton(
                                    onPressed: () {
                                      if (key.currentState!.validate()) {
                                        BlocProvider.of<SignUpCubit>(context)
                                            .signUpUser(
                                              name: nameController.text,
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                                context: context);
                                      }
                                    },
                                    text: 'SIGN UP',
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
