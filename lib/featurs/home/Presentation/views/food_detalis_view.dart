import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/featurs/home/Presentation/Manager/cubits/add_to_curt_cubit/add_to_curt_cubit.dart';

import 'widgets/food_detalis_body.dart';

class FoodDetalisView extends StatelessWidget {
  const FoodDetalisView(
      {super.key,
      required this.imageUrl,
      required this.desc,
      required this.price,
      required this.name});
  final String imageUrl;
  final String desc;
  final String price;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => AddToCurtCubit(),
        child: FoodDetalisBody(
          name: name,
          imageUrl: imageUrl,
          desc: desc,
          price: price,
        ),
      ),
    );
  }
}
