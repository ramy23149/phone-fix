import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/logIn_view_body.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
      //  backgroundColor: kRed,
        body: LogInViewBody(),
      ));
  }
}