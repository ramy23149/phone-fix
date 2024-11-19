import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/constats.dart';

import '../../../Core/text_styles/Styles.dart';
import '../../../Core/widgets/custom_bottom.dart';
import '../../../Core/widgets/custom_text_feild.dart';

void showTextFieldDialog(
    BuildContext context,
    TextEditingController controller,
    void Function() onPressed,
    GlobalKey<FormState> key,) {
  showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: Form(
            key: key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.cancel)),
                    const Spacer(),
                    const Text("اضف نوع المنتج", style: Styles.textStyle14),
                    const Spacer(),
                  ],
                ),
                // const SizedBox(height: 20),
                // Text(
                //   label,
                //   style: Styles.textStyle14,
                // ),
                const SizedBox(height: 20),
                CustomTextField(
                  textEditingController: controller,
                  hinttext: "نوع المنتج(مثال: اسكرينة, وصلة, جراب كاميرا, ...)",
                ),
                const SizedBox(height: 20),
                Center(
                  child: CustomBotton(
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        onPressed();
                      }
                    },
                     width: 100,
                    backgroundColor: kMainAppColor,
                    textColor: Colors.white,
                    text: "اضافه",
                  ),
                )
              ],
            ),
          ),
        );
      });
}
