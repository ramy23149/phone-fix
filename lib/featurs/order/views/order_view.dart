import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/featurs/order/views/widgets/order_view_body.dart';

import '../manager/cubit/paymony_cubit.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymonyCubit(),
      child: const SafeArea(
          child: Scaffold(
        body: OrderViewBody(),
      )),
    );
  }
}
