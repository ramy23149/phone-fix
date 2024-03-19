import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/Password_Recavory_Body.dart';

class PasswordRecavory extends StatelessWidget {
  const PasswordRecavory({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: 
    Scaffold(
      backgroundColor: Colors.black,
      body: PasswordRecavoryBody(),));
  }
}