import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';

import '../text_styles/Styles.dart';

void showDelightfulToast({required String message, required BuildContext context,}) {
  DelightToastBar(
    builder: (context) {
    return ToastCard(
      color: Colors.indigo,
      leading: const Icon(Icons.error,color: Colors.white,),
      title: Text(message,style: Styles.textStyle14.copyWith(color: Colors.white),),
    );
  },
  position: DelightSnackbarPosition.top,
  autoDismiss: true,
  snackbarDuration:const Duration(seconds: 2),
  ).show(context);
}