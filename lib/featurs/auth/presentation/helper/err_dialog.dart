import 'package:flutter/material.dart';

import '../../../../Core/helper/custom_text_button.dart';
import '../../../../Core/text_styles/Styles.dart';



reTryDialog({required BuildContext context, required String content,required void Function() onRetry}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(content,style: Styles.textStyle16,),
        actions: [
          CustomTextButton(onPressed: onRetry, text: "حاول مره اخرى"),
        ],
      );
    },
  );
}
