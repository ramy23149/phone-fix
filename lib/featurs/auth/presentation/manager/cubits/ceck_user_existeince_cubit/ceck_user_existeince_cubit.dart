
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



part 'ceck_user_existeince_state.dart';

class CheckUserExisteniceCubit extends Cubit<CheckUserExisteniceState> {
  CheckUserExisteniceCubit() : super(CheckUserExisteniceInitial());
  Future<void> checkUserExistence(
      {required String phone}) async {
    emit(CheckUserExisteniceLoading());
    try {

        final doc = await FirebaseFirestore.instance
      .collection('users')
      .doc('+20$phone')
      .get();
  if (doc.exists) {
    emit(ThisUserAllreadyExist());
  } else {
    emit(ThisIsNewUser(
      phone: phone,
    ));
  }

} catch (e) {
  emit(CheckUserExisteniceError(error: e.toString()));
}
  }

}
