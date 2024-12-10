import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/featurs/auth/data/enums/user_role_enum.dart';
import 'package:food_delivery_app/featurs/auth/presentation/manager/cubits/ceck_user_existeince_cubit/ceck_user_existeince_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../helper/exist_user_dialog.dart';
import '../../manager/providers/auth_provider.dart';
import 'custom_uper_container.dart';
import 'signUp_store_owner_contanier.dart';
import 'signUp_user_contanier_data.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key});

  @override
  State<SignInViewBody> createState() => _SignInViewBodyState();
}
class _SignInViewBodyState extends State<SignInViewBody> {
    late UserRoleEnum? userRoleEnum;
  @override
  void initState() {
    super.initState();
    userRoleEnum = context.read<AuthUserProvider>().userRole;
  }

  @override
  Widget build(BuildContext context) {
    // return const CustomUperContainer();
    return BlocConsumer<CheckUserExisteniceCubit, CheckUserExisteniceState>(
      listener: (context, state) {
        if (state is ThisUserAllreadyExist) {
          showExistUserDialog(
              context: context,
              message: "يبدو انك لديك حساب بالفعل ابدا بتسجيل الدخول الان");
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is CheckUserExisteniceLoading,
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
                      child: userRoleEnum == UserRoleEnum.user
                      ? const SignUpUserDataContaner()
                      : const SignUpStoreOwnerContanier(),
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
