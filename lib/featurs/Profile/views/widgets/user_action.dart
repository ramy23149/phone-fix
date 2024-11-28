import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../Core/app_router.dart';
import '../../../../Core/text_styles/Styles.dart';

class UserAction extends StatelessWidget {
  const UserAction({
    this.goToAdminView,
    super.key,
    required this.title,
    required this.icon,
    this.dialogTitle,
    this.okBtnText,
    this.onOk,
    this.onCancel,
  });
  final String title;
  final Icon icon;
  final String? dialogTitle;
  final String? okBtnText;
  final void Function()? onOk;
  final void Function()? onCancel;
  final bool? goToAdminView;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (goToAdminView == true) {
          context.push(AppRouter.kAdminView);
        } else {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.question,
            title: dialogTitle,
            btnOkText: okBtnText,
            btnOkOnPress: onOk,
            btnCancelText: 'الغاء',
            btnCancelOnPress: () {},
          ).show();
        }
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
