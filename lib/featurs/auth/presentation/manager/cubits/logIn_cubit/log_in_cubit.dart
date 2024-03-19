import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

import '../../../../../../Core/app_router.dart';
import '../../../../../../Core/widgets/custom_snakBar.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitial());

  Future<void> loginUser(
      {required String email, required String password, required BuildContext context}) async {
    emit(LogInLoading());
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LogInSuccess());
      showSnackBar(context, 'Login successfully');
      context.go(AppRouter.kBottomNavBar);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, 'Wrong email or password');
      }else{emit(LogInFailure(errMassege: e.toString()));}
    }
      }
  
}
