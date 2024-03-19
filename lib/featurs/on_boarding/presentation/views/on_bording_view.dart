import 'package:flutter/material.dart';

import 'widgets/onBording_view_body.dart';



class OnBordingView extends StatelessWidget {
  const OnBordingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body:  OnBordingViewBody()),
    );
  }
}