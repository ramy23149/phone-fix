import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/servers/data_base_methouds.dart';
import 'package:food_delivery_app/Core/helper/Costom_alert_dialog.dart';
import 'package:food_delivery_app/Core/helper/custom_snakBar.dart';
import 'package:food_delivery_app/Core/servers/sherd_pref.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> signUpUser(
      {required String name,
      required String email,
      required String password,
      required BuildContext context}) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SignUpLoading());
      await FirebaseAuth.instance.currentUser!
          .sendEmailVerification()
          .whenComplete(
            () => showAlertDialog(context, 'Verify your email'),
          );
      Map<String, dynamic> addUserInfo = {
        'email': email,
        'name': name,
        'uid': userCredential.user!.uid,
        'Wallet': '0'
      };
    await  DataBaseMethouds().addUserDetails(addUserInfo, userCredential.user!.uid);
    await SherdPrefHelper().setUserEmail(email);
    await SherdPrefHelper().setUserName(name);
    await SherdPrefHelper().setUserUID(userCredential.user!.uid);
    await SherdPrefHelper().setUserWallet('0');
      emit(SignUpSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, 'password too weak');
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, 'The account already exists for that email.');
      } else {
        emit(SignUpFailure(errMassege: e.toString()));
      }
      emit(SignUpInitial());
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