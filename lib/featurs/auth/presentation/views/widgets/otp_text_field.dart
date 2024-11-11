import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:pinput/pinput.dart';

import '../../../data/models/verificatoin_data_model.dart';
import '../../manager/cubits/phone_auth_cubit/phone_auth_cubit.dart';

class OtpTextField extends StatelessWidget {
  const OtpTextField({super.key, required this.data});
  final VerificatoinDataModel data;

  @override
  Widget build(BuildContext context) {
    final otpConttorler = context.read<PhoneAuthCubit>().otpController;
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listener: (context, state) {
        if(state is InvalidOtpError){
          otpConttorler.clear();
        }
      },
      child: Pinput(
        controller: otpConttorler,
        length: 6,
        focusedPinTheme: PinTheme(
          width: 56,
          height: 56,
          textStyle: const TextStyle(
              fontSize: 20,
              color: Color.fromRGBO(30, 60, 87, 1),
              fontWeight: FontWeight.w600),
          decoration: BoxDecoration(
            border: Border.all(color: kMainAppColor),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onCompleted: (pin) => context
            .read<PhoneAuthCubit>()
            .verifyOTP(context: context, pin: pin, data: data),
      ),
    );
  }
}
