import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/featurs/cart/views/widgets/order_view_body.dart';
import 'package:provider/provider.dart';

import '../manager/confirm_order_cubit/paymony_cubit.dart';
import '../manager/providers/user_cart_provider.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserCartProvider>(
      create: (context) => UserCartProvider()..calculateCartTotalPrice(context),
      child: BlocProvider(
        create: (context) => PaymonyCubit(),
        child: const SafeArea(
            child: Scaffold(
          body: OrderViewBody(),
        )),
      ),
    );
  }
}
