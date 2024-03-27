import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../Core/text_styles/Styles.dart';

class UserAction extends StatelessWidget {
  const UserAction({super.key, required this.title, required this.icon, this.onTap});
  final String title;
  final Icon icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        elevation: 4.0,
        child: ListTile(
          onTap: onTap,
          visualDensity: const VisualDensity(vertical: -2.0),
          title: Text(
            title,
            style: Styles.textStyle18,
          ),
          leading: icon,
        ),
      ),
    );
  }
}