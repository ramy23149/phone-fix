import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/widgets/custom_appbar.dart';
import 'check_out_box.dart';
import 'order_list_view.dart';

class CartViewBody extends StatefulWidget {
  const CartViewBody({super.key});

  @override
  State<CartViewBody> createState() => _CartViewBodyState();
}

class _CartViewBodyState extends State<CartViewBody> {
  int total = 0;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
      Column(
        children: [
          CustomAppBar(
            title: 'عربة التسوق',
          ),
          Spacer(),
          ChekOutBox(),
        ],
      ),
      Positioned(
          top: 65,
          bottom: 110,
          right: 0,
          left: 0,
          child: OrderListView()),
    ]);
  }
}
