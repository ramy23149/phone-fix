import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../Core/app_router.dart';
import '../../../../../Core/constats.dart';
import '../../../../../Core/helper/custom_snakBar.dart';
import '../../../../../Core/text_styles/Styles.dart';
import '../../../../../Core/widgets/custom_bottom.dart';
import '../../../../../Core/widgets/custom_loadingIndecator.dart';
import '../../../../../Core/widgets/custom_text_feild.dart';
import '../../manager/cubits/signUp_cubit/sign_up_cubit.dart';

class SignUpUserDataContaner extends StatelessWidget {
  const SignUpUserDataContaner({
    super.key,
    required this.fromKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> fromKey;
  final TextEditingController nameController;
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
                      key: fromKey,
                      child: Column(
                        children: [
                          const Spacer(),
                          const Text(
                            'Sign up',
                            style: Styles.textStyle25,
                          ),
                          const Spacer(),
                           CustomTextField(
                            textEditingController: nameController,
                            hinttext: 'Name',
                            //icon: const Icon(Icons.person_outline),
                          ),
                          const Spacer(),
                          CustomTextField(
                            textEditingController: emailController,
                            hinttext: 'Email',
                          //  icon: const Icon(Icons.email_outlined),
                          ),
                          const Spacer(),
                          CustomTextField(
                            textEditingController: passwordController,
                            obscureText: true,
                            hinttext: 'Password',
                          //  icon: const Icon(Icons.password_outlined),
                          ),
                          const Spacer(
                            flex: 4,
                          ),
                          CustomBotton(
                            onPressed: () {
                              if (fromKey.currentState!.validate()) {
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
                            backgroundColor: kMainAppColor,
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
    );
  }
}
