import 'package:flutter/material.dart';

import 'widgets/food_detalis_body.dart';

class FoodDetalisView extends StatelessWidget {
  const FoodDetalisView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FoodDetalisBody(),
    );
  }
}
