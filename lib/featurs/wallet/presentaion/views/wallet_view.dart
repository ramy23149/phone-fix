import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/api_service.dart';
import 'package:food_delivery_app/featurs/cart/data/repos/payment_repos/payment_repo_imple.dart';
import 'package:food_delivery_app/featurs/wallet/presentaion/views/widgets/wallet_view_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cart/manager/add_mony_cubit/add_mony_cubit.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddMonyCubit(WalletRepoImple(ApiService(Dio()))),//================git Locator
      child: const SafeArea(
        child: Scaffold(
          body: WalletViewBody(),
        ),
      ),
    );
  }
}
