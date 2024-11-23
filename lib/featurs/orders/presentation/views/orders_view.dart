import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery_app/featurs/orders/presentation/views/widgets/orders_view_body..dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: OrdersViewBody()
    );
  }
}