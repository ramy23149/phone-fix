import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomLoadingIndecator extends StatelessWidget {
  const CustomLoadingIndecator({super.key});

  @override
  Widget build(BuildContext context) {
    return   Center(
      child: Lottie.asset('assets/animaions/Animation - 1712013217863.json',width: 200, height: 200,),
    );
  }
}
