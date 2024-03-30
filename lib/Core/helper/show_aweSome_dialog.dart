import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/widgets.dart';

void showAwesomeDialog(
    BuildContext context, Function() onPress) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.question,
    animType: AnimType.topSlide,
    title: 'Delete from cart?',
    btnOkText: 'yes',
    btnOkOnPress: onPress,
    btnCancelText: 'No',
    btnCancelOnPress: () {},
  ).show();
}
