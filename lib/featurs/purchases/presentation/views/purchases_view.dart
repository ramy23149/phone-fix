import 'package:flutter/material.dart';

import 'widgets/purchases_veiw_body.dart';


class PurchasesView extends StatelessWidget {
  const PurchasesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PurchasesViewBody(),
    );
  }
}