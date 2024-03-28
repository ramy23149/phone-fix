import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../Core/text_styles/Styles.dart';

class UserAction extends StatelessWidget {
  const UserAction({
    super.key,
    required this.title,
    required this.icon,
    required this.dialogTitle,
    required this.okBtnText,
    this.onOk, this.onCancel,
  });
  final String title;
  final Icon icon;
  final String dialogTitle;
  final String okBtnText;
  final void Function()? onOk;
    final void Function()? onCancel;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.question,
          title: dialogTitle,
          btnOkText: okBtnText,
          btnOkOnPress: onOk,
          btnCancelText: 'cancel',
          btnCancelOnPress: onCancel
        ).show();
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          elevation: 4.0,
          child: ListTile(
            visualDensity: const VisualDensity(vertical: -2.0),
            title: Text(
              title,
              style: Styles.textStyle18,
            ),
            leading: icon,
          ),
        ),
      ),
    );
  }
}
