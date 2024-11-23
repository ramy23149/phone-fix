import 'dart:async'; // Import this for the Timer class

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Core/app_router.dart';
import 'package:food_delivery_app/Core/constats.dart';

import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../Core/helper/Costom_alert_dialog.dart';
import '../../../../../Core/helper/custom_snakBar.dart';
import '../../../../../Core/helper/custom_text_button.dart';
import '../../../../../Core/text_styles/Styles.dart';
import '../../../data/models/verificatoin_data_model.dart';
import '../../helper/err_dialog.dart';
import '../../manager/cubits/phone_auth_cubit/phone_auth_cubit.dart';
import 'otp_text_field.dart';

class VerifyViewBody extends StatefulWidget {
  const VerifyViewBody({super.key, required this.data});
  final VerificatoinDataModel data;

  @override
  State<VerifyViewBody> createState() => _VerifyViewBodyState();
}

class _VerifyViewBodyState extends State<VerifyViewBody> {
  Timer? _timer;
  int _start = 60;
  bool _isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    // Start the countdown timer when the screen is initialized
    _startTimer();
    context.read<PhoneAuthCubit>().verifyPhone(
          context: context,
          phone: widget.data.phone,
        );
  }

  void _startTimer() {
    _isButtonDisabled = true;
    _start = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_start == 0) {
        setState(() {
          _isButtonDisabled = false;
        });
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer if the screen is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhoneAuthCubit, PhoneAuthState>(
      builder: (context, state) {
        return BlocListener<PhoneAuthCubit, PhoneAuthState>(
          listener: (context, state) {
            if (state is PhoneAuthSuccess) {
              showSnackBar(context, "تم التحقق بنجاح");
              context.go(AppRouter.kBottomNavBar,extra: state.userRole);
            }else if(state is GoToResetPasswordView){
              context.go(AppRouter.kCreateNewPasswordView,extra: state.updatePassowrdModel);
            } else if (state is PhoneAuthError) {
              showAlertDialog(context, state.error, null, null);
              _timer?.cancel();
            } else if (state is InvalidPhoneNumber) {
              reTryDialog(
                context: context,
                content: state.error,
                onRetry: () {
                  context.pop(); //close dialog
                  context.pop(); //close verify view
                },
              );
              _timer?.cancel();
            } else if (state is InvalidOtpError) {
              reTryDialog(
                context: context,
                content: state.error,
                onRetry: () {
                  _timer?.cancel();
                  context.pop();
                  context.read<PhoneAuthCubit>().verifyPhone(
                        context: context,
                        phone: widget.data.phone,
                      );
                  _startTimer(); // Start the timer again
                },
              );
              _timer?.cancel();
            }
          },
          child: ModalProgressHUD(
            inAsyncCall: state is PhoneAuthLoading, //testing code
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 50),
                    child: Text(
                      "تحقق من رقم الهاتف",
                      style: Styles.textStyle25,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text.rich(
                    TextSpan(
                      text: "تم ارسال رمز التحقق الى:",
                      style: Styles.textStyle16,
                      children: [
                        TextSpan(
                          text: '  0${widget.data.phone}',
                          style: Styles.textStyle14.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  OtpTextField(data: widget.data),
                  const SizedBox(height: 15),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      _isButtonDisabled
                          ? 'لم تستلم الرمز؟ $_start ثانيه'
                          : "لم تستلم الرمز؟ ",
                      style: Styles.textStyle16,
                    ),
                  ),
                  CustomTextButton(
                    onPressed: _isButtonDisabled
                        ? null
                        : () {

                            context.read<PhoneAuthCubit>().verifyPhone(
                                  context: context,
                                  phone: widget.data.phone,
                                );
                            _startTimer(); // Start the timer again
                          },
                    text: "اعاده ارسال الرمز",
                    textStyle: TextStyle(
                      decoration: TextDecoration.underline,
                      color: _isButtonDisabled
                          ? Colors.black.withOpacity(0.5)
                          : kMainAppColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
