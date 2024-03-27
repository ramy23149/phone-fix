import 'package:flutter/material.dart';

import '../../../../Core/text_styles/Styles.dart';

class UserInfo extends StatelessWidget {
  const UserInfo(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle});

  final Icon icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        elevation: 4.0,
        child: ListTile(
          visualDensity: const VisualDensity(vertical: -4.0),
          title: Text(
            title,
            style: Styles.textStyle16,
          ),
          subtitle: Text(
            subtitle,
            style: Styles.textStyle16,
          ),
          leading: icon,
        ),
      ),
    );
  }
}
