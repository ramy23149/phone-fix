import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/featurs/auth/data/models/user_info_model.dart';
import 'package:food_delivery_app/featurs/auth/data/models/verificatoin_data_model.dart';
import 'package:food_delivery_app/featurs/auth/presentation/manager/cubits/ceck_user_existeince_cubit/ceck_user_existeince_cubit.dart';
import 'package:food_delivery_app/featurs/auth/presentation/views/widgets/district_suggestion_field.dart';
import 'package:go_router/go_router.dart';
import '../../../../../Core/app_router.dart';
import '../../../../../Core/constats.dart';
import '../../../../../Core/functions/validate_the_egyption_phone_number.dart';
import '../../../../../Core/text_styles/Styles.dart';
import '../../../../../Core/widgets/custom_bottom.dart';
import '../../../../../Core/widgets/custom_text_feild.dart';

class SignUpUserDataContaner extends StatefulWidget {
  const SignUpUserDataContaner({
    super.key,
  });

  @override
  State<SignUpUserDataContaner> createState() => _SignUpUserDataContanerState();
}

class _SignUpUserDataContanerState extends State<SignUpUserDataContaner> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController areaController = TextEditingController();

  GlobalKey<FormState> fromKey = GlobalKey();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    areaController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckUserExisteniceCubit, CheckUserExisteniceState>(
      listener: (context, state) {
        if (state is ThisIsNewUser) {
          context.push(AppRouter.kVerifyView,
              extra: VerificatoinDataModel(
                  data: dartz.Left(UserInfoModel(
                      phone: phoneNumberController.text,
                      name: nameController.text,
                      district: areaController.text)),
                  isForgotPasswordCase: false,
                  phone: phoneNumberController.text,
                  isNew: true));
        }
      },
      child: Material(
        borderRadius: BorderRadius.circular(17),
        elevation: 5.0,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17), color: kWhite),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocConsumer<CheckUserExisteniceCubit,
                CheckUserExisteniceState>(
              listener: (context, state) {},
              builder: (context, state) {
                return SingleChildScrollView(
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
                          validator: (value) =>
                              validateEgyptianPhoneNumber(value),
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
                              BlocProvider.of<CheckUserExisteniceCubit>(context)
                                  .checkUserExistence(
                                phone: phoneNumberController.text,
                              );
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
      ),
    );
  }
}
