import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/featurs/auth/data/enums/user_role_enum.dart';
import 'package:food_delivery_app/featurs/auth/presentation/manager/providers/auth_provider.dart';
import '../../../../../Core/constats.dart';
import 'custom_uper_container.dart';
import 'signUp_store_owner_contanier.dart';
import 'signUp_user_contanier_data.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key});

  @override
  State<SignInViewBody> createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<SignInViewBody> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  GlobalKey<FormState> fromKey = GlobalKey();
  late UserRoleEnum? userRoleEnum;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userRoleEnum = context.read<AuthUserProvider>().userRole;
  }

  @override
  Widget build(BuildContext context) {
    // return const CustomUperContainer();
    return Stack(
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
                    color: kWhite
                  ),
                ),
        ),
     userRoleEnum==UserRoleEnum.user? Positioned(
          right: 20,
          left: 20,
          top: 100,
         bottom: 0,
          child: SignUpUserDataContaner(
              fromKey: fromKey,
              nameController: nameController,
              emailController: emailController,
              passwordController: passwordController)
        ):const Positioned(
          right: 10,
          left: 10,
          top: 10,
          bottom: 0,
          child: SignUpStoreOwnerContanier()),
      ],
    );
  }
}
