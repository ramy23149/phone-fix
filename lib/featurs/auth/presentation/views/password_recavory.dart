import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Core/constats.dart';
import 'widgets/Password_Recavory_Body.dart';

class PasswordRecavory extends StatelessWidget {
  const PasswordRecavory({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            kMainAppColor, // Start color
            Colors.red, // End color
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const PasswordRecavoryBody(),
    ),
  );
  }
}