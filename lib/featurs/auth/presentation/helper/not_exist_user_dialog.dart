import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../Core/app_router.dart';
import '../../../../Core/helper/custom_text_button.dart';

showNotExistUserDialog(
    {required BuildContext context, required String message}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              context.pop();
            },
            iconSize: 25,
            icon: const Icon(Icons.close, color: Colors.red),
          ),
        ),
        content: Text(message),
        actions: [
          CustomTextButton(
              onPressed: () {
                context.pop(); //close dialog
                context.push(AppRouter.kSelectRoleView);
              },
              text: 'انشاء حساب'),
        ],
      );
    },
  );
}
