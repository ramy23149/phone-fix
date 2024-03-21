import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/Core/text_styles/Styles.dart';
import 'package:food_delivery_app/Core/widgets/custom_bottom.dart';
import 'package:food_delivery_app/Core/widgets/payment_textFeild.dart';
import 'package:go_router/go_router.dart';

void showPaymentDialog(BuildContext context,TextEditingController controller,void Function() onPressed,GlobalKey<FormState> key ) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Form(
            key: key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () {
                          context.pop();
                        },
                        child: const Icon(Icons.cancel)),
                    //  SizedBox(width: 30,),
                    const Spacer(),
                    Text("Add Money",
                        style: Styles.textStyle18.copyWith(color: kCyan)),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Amount',
                  
                  style: Styles.textStyle14,
                ),
                const SizedBox(height: 10),
                PaymentTextFiald(
                  controller: controller,
                  hintText: 'Enter Amount',),
                const SizedBox(height: 20),
                Center(
                  child: CustomBotton(
                    onPressed: onPressed,
                    width:100,
                    backgroundColor: kCyan,
                    textColor: kWhite,
                    text: 'Pay',
                  ),
                )
              ],
            ),
          ),
        );
      });
}
