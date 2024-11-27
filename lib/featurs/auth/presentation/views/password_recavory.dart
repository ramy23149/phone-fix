import 'package:flutter/material.dart';
import '../../../../Core/constats.dart';
import 'widgets/Password_Recavory_Body.dart';

class PasswordRecavoryView extends StatelessWidget {
  const PasswordRecavoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            kMainAppColor,
            Colors.red, 
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

