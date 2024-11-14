import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/featurs/home/Presentation/Manager/cubits/add_to_curt_cubit/add_to_curt_cubit.dart';

import '../../data/models/product_model.dart';
import 'widgets/food_detalis_body.dart';

class FoodDetalisView extends StatelessWidget {
  const FoodDetalisView({
    super.key, required this.productModel,
  });
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => AddToCurtCubit(),
        child: FoodDetalisBody(
productModel: productModel,
        ),
      ),
    );
  }
}
