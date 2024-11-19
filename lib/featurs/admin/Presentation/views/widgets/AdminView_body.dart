import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Core/app_router.dart';
import 'package:food_delivery_app/Core/helper/custom_snakBar.dart';
import 'package:food_delivery_app/Core/widgets/Text_field_withBorder.dart';
import 'package:food_delivery_app/Core/widgets/custom_loadingIndecator.dart';
import 'package:food_delivery_app/featurs/admin/Presentation/views/widgets/Lower_contaner.dart';
import 'package:food_delivery_app/featurs/auth/presentation/manager/cubits/check_password_cubit/check_password_cubit.dart';
import 'package:go_router/go_router.dart';
import '../../../../../Core/constats.dart';
import '../../../../../Core/text_styles/Styles.dart';
import '../../../../../Core/widgets/custom_bottom.dart';
import '../../manager/cubits/Add_Item_cubit/add_items_cubit.dart';
import 'Uper_contaner.dart';

class AdminViewBody extends StatefulWidget {
  const AdminViewBody({super.key});

  @override
  State<AdminViewBody> createState() => _AdminViewBodyState();
}

class _AdminViewBodyState extends State<AdminViewBody> {
  late bool isPhoneAccessoriesStore;
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  bool isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordController.dispose();
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
      isPhoneAccessoriesStore =
        context.read<AddItemsCubit>().isAccessoriesStore(context);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckPasswordCubit, CheckPasswordState>(
      builder: (context, state) {
        if (state is TruePassword) {
          passwordController.clear();
          
          Future.microtask(() {
            if(isPhoneAccessoriesStore){
              context.push(AppRouter.kAdminHome);
            }else{
              context.push(AppRouter.kSelectWhatSparePartsStoreNeedToAddView);
            }
          });
        //  context.push(AppRouter.kAdminHome);
        } else if (state is WrongPassword) {
          Future.microtask(() {
            showSnackBar(context, state.message);
          });
        }
        return SingleChildScrollView(
          child: Stack(
            children: [
              const UperContainer(),
              const LowerContaner(),
              const Positioned(
                right: 0,
                left: 0,
                top: 18,
                child: Center(
                  child: Text('Let\'s start with\nAdmin!',
                      style: Styles.textStyle25),
                ),
              ),
              Positioned(
                right: 30,
                left: 30,
                top: 130,
                bottom: 260,
                child: Material(
                  borderRadius: BorderRadius.circular(17),
                  elevation: 5.0,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17), color: kWhite),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Form(
                        key: key,
                        child: Column(
                          children: [
                            const Spacer(
                              flex: 2,
                            ),
                            // BorderTextFiald(
                            //     hintText: 'Username',
                            //     controller: userNameController),
                            // const Spacer(),
                            BorderTextFiald(
                              obscure: true,
                              hintText: 'Password',
                              controller: passwordController,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Spacer(),
                            CustomBotton(
                              width: double.infinity,
                              onPressed: () {
                                if (key.currentState!.validate()) {
                                  BlocProvider.of<CheckPasswordCubit>(context)
                                      .checkAdminPassword(
                                          context: context,
                                          password: passwordController.text);
                                }
                              },
                              text: 'التالي',
                              backgroundColor: kMainAppColor,
                              textColor: kWhite,
                              borderRadius: BorderRadius.circular(10),
                              child: state is CheckPasswordLoading
                                  ? const CustomLoadingIndecator()
                                  : Text(
                                      'التالي',
                                      style: Styles.textStyle18.copyWith(
                                        color: kWhite,
                                      ),
                                    ),
                            ),
                            const Spacer(
                              flex: 3,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
