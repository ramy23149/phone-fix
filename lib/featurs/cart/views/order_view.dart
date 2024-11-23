import 'package:flutter/material.dart';
import 'package:food_delivery_app/featurs/cart/views/widgets/order_view_body.dart';
import 'package:provider/provider.dart';

import '../manager/providers/user_cart_provider.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserCartProvider>(
      create: (context) => UserCartProvider()..calculateCartTotalPrice(context),
      child: const SafeArea(
          child: Scaffold(
        body: OrderViewBody(),
      )),
    );
  }
}
