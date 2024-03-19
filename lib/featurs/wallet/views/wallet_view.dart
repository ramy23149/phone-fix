import 'package:flutter/material.dart';
import 'package:food_delivery_app/featurs/wallet/views/widgets/wallet_view_body.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: WalletViewBody(),
      ),
    );
  }
}