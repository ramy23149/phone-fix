import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/user_info_model.dart';
import '../manager/cubits/phone_auth_cubit/phone_auth_cubit.dart';
import 'widgets/verify_view_body.dart';

class VerifyView extends StatelessWidget {
  const VerifyView({super.key, required this.userInfo});
  final UserInfoModel userInfo;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneAuthCubit(
      ),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(), //to hide keyboard
        child: Scaffold(
          appBar: AppBar(),
          body: VerifyViewBody(
          userInfo: userInfo,
          ),
        ),
      ),
    );
  }
}