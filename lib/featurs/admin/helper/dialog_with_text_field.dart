import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/Core/widgets/custom_text_feild.dart';

import '../../../Core/text_styles/Styles.dart';
import '../../../Core/widgets/custom_bottom.dart';

void showTextFieldDialog(
  BuildContext context,
  TextEditingController controller,
  void Function() onPressed,
  bool isPhoneAccessoriesStore,
) {
  final formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        content: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800), // Limit dialog size
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.cancel),
                    ),
                    const Spacer(),
                    const Text("اضف نوع المنتج", style: Styles.textStyle14),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  textEditingController: controller,
                  hinttext:
                      "نوع المنتج (مثال: اسكرينة, وصلة, جراب كاميرا, ...)",
                  validator: (value) {
                    if(value == null || value.isEmpty) {
                      return "من فضلك ادخل نوع المنتج";
                    }else if(!(kPhoneAccessories.contains(value)||!(kRepairableParts.contains(value)))) {
                      return "القيمه المدخله غير صحيحه";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: CustomBotton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        onPressed();
                      //  Navigator.pop(context); // Close the dialog after validation
                      }
                    },
                    width: 100,
                    backgroundColor: kMainAppColor,
                    textColor: Colors.white,
                    text: "اضافه",
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
