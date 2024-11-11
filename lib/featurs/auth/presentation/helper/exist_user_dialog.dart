import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../Core/app_router.dart';
import '../../../../Core/helper/custom_text_button.dart';



showExistUserDialog({required BuildContext context, required String message}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content:  Text(message),
        actions: [
          CustomTextButton(
              onPressed: () {
                context.pop();//close dialog
                context.go(AppRouter.kLogInView);
              },
              text: ''),
        ],
      );
    },
  );
}
