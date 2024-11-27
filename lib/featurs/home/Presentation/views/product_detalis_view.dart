import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/product_model.dart';
import '../Manager/cubits/add_to_curt_cubit/add_to_curt_cubit.dart';
import 'widgets/products_detalis_body.dart';

class ProductDetalisView extends StatelessWidget {
  const ProductDetalisView({
    super.key,
    required this.productModel,
  });
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => AddToCurtCubit(),
        child: ProductDetalisBody(
          productModel: productModel,
        ),
      ),
    );
  }
}
