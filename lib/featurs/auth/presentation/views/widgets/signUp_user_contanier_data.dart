import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/featurs/auth/presentation/views/widgets/district_suggestion_field.dart';
import 'package:go_router/go_router.dart';

import '../../../../../Core/app_router.dart';
import '../../../../../Core/constats.dart';
import '../../../../../Core/functions/validate_the_egyption_phone_number.dart';
import '../../../../../Core/helper/custom_snakBar.dart';
import '../../../../../Core/text_styles/Styles.dart';
import '../../../../../Core/widgets/custom_bottom.dart';
import '../../../../../Core/widgets/custom_loadingIndecator.dart';
import '../../../../../Core/widgets/custom_text_feild.dart';
import '../../manager/cubits/phone_auth_cubit/phone_auth_cubit.dart';

class SignUpUserDataContaner extends StatelessWidget {
  const SignUpUserDataContaner({
    super.key,
    required this.fromKey,
    required this.nameController,
    required this.phoneNumberController, required this.areaController,
  });

  final GlobalKey<FormState> fromKey;
  final TextEditingController nameController;
  final TextEditingController phoneNumberController;
  final TextEditingController areaController;

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
          child: BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
            listener: (context, state) {
              if (state is PhoneAuthSuccess) {
                //showSnackBar(context, 'Account successfully created,login now');
                context.go(AppRouter.kBottomNavBar);
                showSnackBar(context, 'Welcome');
              }
            },
            builder: (context, state) {
              return state is PhoneAuthLoading
                  ? const CustomLoadingIndecator()
                  : SingleChildScrollView(
                      child: Form(
                        key: fromKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'انشاء حساب',
                              style: Styles.textStyle25,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CustomTextField(
                              textEditingController: nameController,
                              hinttext: 'الاسم',
                              //icon: const Icon(Icons.person_outline),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                           CustomTextField(
                    textEditingController: phoneNumberController,
                    hinttext: 'رقم الهاتف',
                    prefix: const Text(
                      "+20",
                    ),
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    validator: (value) => validateEgyptianPhoneNumber(value),
                  ),
                            const SizedBox(
                              height: 15,
                            ),
                            DistrictSuggestionField(
                              controller: areaController,
                            ),
                            // const SizedBox(
                            //   height: 25,
                            // ),
                            CustomBotton(
                              onPressed: () {
                                if (fromKey.currentState!.validate()) {
                                  BlocProvider.of<PhoneAuthCubit>(context)
                                      .verifyPhone(
                                        phone: phoneNumberController.text,
                                          context: context);
                                }
                              },
                              text: 'انشاء حسابي',
                              backgroundColor: kMainAppColor,
                              textColor: kWhite,
                              borderRadius: BorderRadius.circular(90),
                            ),
                            const SizedBox(
                              height: 15,
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
