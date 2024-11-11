import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/app_router.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/Core/widgets/Custom_text_bottom.dart';
import 'package:food_delivery_app/Core/widgets/custom_bottom.dart';
import 'package:go_router/go_router.dart';

import '../../../../../Core/functions/validate_the_egyption_phone_number.dart';
import '../../../../../Core/widgets/custom_text_feild.dart';
import '../../../data/models/verificatoin_data_model.dart';

class PasswordRecavoryBody extends StatefulWidget {
  const PasswordRecavoryBody({super.key});

  @override
  State<PasswordRecavoryBody> createState() => _PasswordRecavoryBodyState();
}

class _PasswordRecavoryBodyState extends State<PasswordRecavoryBody> {
  TextEditingController phoneController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Container(
          alignment: Alignment.topCenter,
          child: const Text(
            "استعادة كلمة المرور",
            style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          "ادخل رقم هاتفك",
          style: Styles.textStyle20.copyWith(color: kWhite),
        ),
        Expanded(
            child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 70,
                      ),
                      CustomTextField(
                        textEditingController: phoneController,
                        hinttext: 'رقم الهاتف',
                        prefix: const Text(
                          "🇪🇬 +20"
                        ),
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        validator: (value) =>validateEgyptianPhoneNumber(value),
                        
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      CustomBotton(
                        text: 'التالي',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.pushReplacement(
                                AppRouter.kVerifyView,
                                extra: VerificatoinDataModel(
                                  data:null,
                                  phone: phoneController.text,
                                  isForgotPasswordCase: true,
                                  isNew: false
                                ));
                          }
                        },
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        CustomTextButtom(text: "انشاء حساب", onPressed:  () {
                              context.go(AppRouter.kSignUpView);
                            },),
                          const Text(
                            "ليس لديك حساب؟",
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          
                        ],
                      )
                    ],
                  ),
                ))),
      ],
    );
  }
}
