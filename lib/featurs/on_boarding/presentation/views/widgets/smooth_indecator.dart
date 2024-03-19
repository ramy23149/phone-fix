import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SmoothIndecator extends StatelessWidget {
  const SmoothIndecator({super.key, required this.activeDot});

  final int activeDot;

  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: activeDot, count: 3,
      effect: const WormEffect(dotHeight: 12,dotWidth: 12,activeDotColor: Colors.black),
      );
  }
}
