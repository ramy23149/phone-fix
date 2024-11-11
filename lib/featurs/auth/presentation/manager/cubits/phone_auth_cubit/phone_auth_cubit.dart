


import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/user_info_model.dart';

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  PhoneAuthCubit() : super(PhoneAuthInitial());
  TextEditingController otpController = TextEditingController();

//  final AfterSuccessLoginActionsEnum whatAfterSuccess;
  String verificationcode = '';

  Future<void> verifyPhone({
    required String phone,
    required BuildContext context,
  }) async {
    log('Starting phone verification for +20$phone');

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+20$phone",
        verificationCompleted: (PhoneAuthCredential credential) async {
          log('Verification completed automatically with credential: $credential');
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              log('User signed in successfully: ${value.user}');

              emit(PhoneAuthSuccess());
            } else {
              log('User sign-in failed: $value');
              emit(PhoneAuthError(error: 'Automatic sign-in failed'));
            }
          }).catchError((error) {
            log('Error during automatic sign-in: $error');
            emit(PhoneAuthError(
                error: "Error during automatic sign-in: $error"));
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            emit(InvalidPhoneNumber(error: 'Invalid phone number'));
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          log('Code sent to +20$phone with verificationId: $verificationId');
          verificationcode = verificationId;
          emit(PhoneAuthCodeSent(
              verificationId: verificationId, resendToken: resendToken));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          log('Auto-retrieval timeout for verificationId: $verificationId');
          verificationcode = verificationId;
          if (!isClosed) {
            emit(CodeAutoRetrievalTimeout(error: 'Auto-retrieval timeout'));
          }
        },
        timeout: const Duration(seconds: 60),
      );
    } catch (e) {
      log('Error during phone verification: $e');
      emit(PhoneAuthError(error: e.toString()));
    }
  }

  Future<void> verifyOTP(
      {required BuildContext context,
      required String pin,
      required UserInfoModel userInfo}) async {
    log('Starting OTP verification with code: $pin and verificationId: $verificationcode');
    emit(PhoneAuthLoading());
    try {
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationcode, smsCode: pin),
      );

      if (userCredential.user != null) {
        log('User signed in successfully: ${userCredential.user}');

        if (userInfo.newUser == true) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc('+20${userInfo.phone}')
              .set({
            'phone': '+20${userInfo.phone}',
            'name': userInfo.name,
            'userId': userCredential.user!.uid
          });
        }
      }
    } catch (e) {
      log('Error during OTP verification: $e');
      // ignore: use_build_context_synchronously
      //  FocusScope.of(context).unfocus();
      // ignore: use_build_context_synchronously
      emit(InvalidOtpError(error: "الكود غير صحيح"));
    }
  }
}


// FirebaseAuth.instance
//   .authStateChanges()
//   .listen((User user) {
//     if (user != null && user.emailVerified) {
//       // Redirect to the homepage
//       Navigator.pushReplacementNamed(context, '/homepage');
//     }