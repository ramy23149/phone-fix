import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/Core/servers/sherd_pref.dart';
import 'package:food_delivery_app/featurs/auth/data/enums/user_role_enum.dart';

part 'ceck_user_existeince_state.dart';

class CheckUserExisteniceCubit extends Cubit<CheckUserExisteniceState> {
  CheckUserExisteniceCubit() : super(CheckUserExisteniceInitial());
  Future<void> checkUserExistence(
      {required String phone, required UserRoleEnum? role}) async {
    emit(CheckUserExisteniceLoading());
    try {
      if (role == UserRoleEnum.user) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc('+20$phone')
            .get();
        if (doc.exists) {
          emit(ThisUserAllreadyExist(doc: doc));
        } else {
          emit(ThisIsNewUser(
            phone: phone,
          ));
        }
    await  SherdPrefHelper().setRole(UserRoleEnum.user);
      } else if (role == UserRoleEnum.storeOwner) {
        final doc = await FirebaseFirestore.instance
            .collection('stores')
            .doc('+20$phone')
            .get();
        if (doc.exists) {
          emit(ThisUserAllreadyExist(doc: doc));
        } else {
          emit(ThisIsNewUser(
            phone: phone,
          ));
        }
        await  SherdPrefHelper().setRole(UserRoleEnum.storeOwner);
      } else if (role == null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc('+20$phone')
          .get();

      if (userDoc.exists) {
        await  SherdPrefHelper().setRole(UserRoleEnum.user);
        emit(ThisUserAllreadyExist(doc: userDoc));
        return;
      }

      // If not found in 'users', check in 'stores' collection
      final storeDoc = await FirebaseFirestore.instance
          .collection('stores')
          .doc('+20$phone')
          .get();

      if (storeDoc.exists) {
        await  SherdPrefHelper().setRole(UserRoleEnum.storeOwner);
        emit(ThisUserAllreadyExist(doc: storeDoc));
      } else {
        // If not found in either collection
        emit(ThisIsNewUser(phone: phone));
      }
      }
    } catch (e) {
      emit(CheckUserExisteniceError(error: e.toString()));
    }
  }
}
