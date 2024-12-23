import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Core/servers/sherd_pref.dart';
import 'package:food_delivery_app/featurs/auth/data/enums/store_type_enum.dart';
import 'package:food_delivery_app/featurs/auth/data/enums/user_role_enum.dart';

import '../../../../data/models/update_passowrd_model.dart';
import '../../../../data/models/verificatoin_data_model.dart';

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

              emit(PhoneAuthSuccess(userRole: UserRoleEnum.user.getDisplayName));
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
      required VerificatoinDataModel data}) async {
    log('Starting OTP verification with code: $pin and verificationId: $verificationcode');
    emit(PhoneAuthLoading());
    try {
      String? userRole;
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationcode, smsCode: pin),
      );
      if (data.isForgotPasswordCase) {
        UserRoleEnum userRole = await getUserRoleInForgotPassswordCase(
          phone: data.phone,
        );
        emit(GoToResetPasswordView(
            updatePassowrdModel: UpdatePassowrdModel(
                phoneNumber: data.phone, userRole: userRole)));
        return;
      } else if (data.data != null && data.isNew) {
        data.data!.fold((userInfoModel) async {
          await FirebaseFirestore.instance
              .collection('users')
              .doc('+20${data.phone}')
              .set({
            'phoneNumber': '+20${data.phone}',
            'name': userInfoModel.name,
            'image': '',
            'userId': userCredential.user!.uid,
            'district': userInfoModel.district,
            'password': userInfoModel.password
          });
          //sheredPrefs do not forgot to add
          await SherdPrefHelper().setRole(UserRoleEnum.user);
          await SherdPrefHelper().setName(userInfoModel.name);
          await SherdPrefHelper().setImage(userInfoModel.image);
          await SherdPrefHelper().setDistricte(userInfoModel.district);
          userRole = UserRoleEnum.user.getDisplayName;
        }, (storeInfoModel) async {
          Reference ref = FirebaseStorage.instance
              .ref()
              .child('images')
              .child("+20${data.phone}");
          UploadTask uploadTask = ref.putFile(storeInfoModel.storeLogoUrl);
          String url = await (await uploadTask).ref.getDownloadURL();
          FirebaseFirestore.instance
              .collection('stores')
              .doc('+20${data.phone}')
              .set({
            'phoneNumber': '+20${data.phone}',
            'name': storeInfoModel.storeName,
            'image': url,
            'userId': userCredential.user!.uid,
            'district': storeInfoModel.storeAddress,
            'type': storeInfoModel.storeType.getDisplayName,
            'password': storeInfoModel.password
          });
          await SherdPrefHelper().setRole(UserRoleEnum.storeOwner);
          await SherdPrefHelper().setName(storeInfoModel.storeName);
          await SherdPrefHelper().setStoreType(storeInfoModel.storeType);
          await SherdPrefHelper().setImage(url);
          await SherdPrefHelper().setDistricte(storeInfoModel.storeAddress);
          userRole = UserRoleEnum.storeOwner.getDisplayName;
        });
        await SherdPrefHelper().setPhoneNumber("+20${data.phone}");

        emit(PhoneAuthSuccess(userRole: userRole??UserRoleEnum.user.getDisplayName));
      }
      // if (userCredential.user != null) {
      //   log('User signed in successfully: ${userCredential.user}');

      //   if (data.isNew == true) {
      //     await FirebaseFirestore.instance
      //         .collection('users')
      //         .doc('+20${data.phone}')
      //         .set({
      //       'phone': '+20${data.phone}',
      //       'name': data.data, //solve this issue
      //       'userId': userCredential.user!.uid
      //     });
      //   }
      // }
    } catch (e) {
      log('Error during OTP verification: $e');
      // ignore: use_build_context_synchronously
      //  FocusScope.of(context).unfocus();
      // ignore: use_build_context_synchronously
      emit(InvalidOtpError(error: "الكود غير صحيح"));
    }
  }

  Future<UserRoleEnum> getUserRoleInForgotPassswordCase(
      {required String phone}) async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc('+20$phone')
        .get();

    if (userDoc.exists) {
      return UserRoleEnum.user;
    }

    // If not found in 'users', check in 'stores' collection
    final storeDoc = await FirebaseFirestore.instance
        .collection('stores')
        .doc('+20$phone')
        .get();

    if (storeDoc.exists) {
      return UserRoleEnum.storeOwner;
    } else {
      return UserRoleEnum.user;
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