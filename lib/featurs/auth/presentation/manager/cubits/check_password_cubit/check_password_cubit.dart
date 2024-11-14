import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/servers/sherd_pref.dart';
import 'package:food_delivery_app/featurs/home/Presentation/Manager/providers/customer_data_provider.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

import '../../../../data/enums/store_type_enum.dart';
import '../../../../data/enums/user_role_enum.dart';

part 'check_password_state.dart';

class CheckPasswordCubit extends Cubit<CheckPasswordState> {
  CheckPasswordCubit() : super(CheckPasswordInitial());
  Future<void> checkPassowrd(
      DocumentSnapshot<Map<String, dynamic>> doc, String password) async {
    emit(CheckPasswordLoading());
    try {
      if (doc['password'] == password) {
        await SherdPrefHelper().setPhoneNumber(doc['phoneNumber']);
        await SherdPrefHelper().setName(doc['name']);
        await SherdPrefHelper().setImage(doc['image']);
        await SherdPrefHelper().setDistricte(doc['district']);
        final userRole = await SherdPrefHelper().getUserRole();
        if (userRole == UserRoleEnum.storeOwner.getDisplayName) {
          final storeType = doc['type'];
          await SherdPrefHelper().setStoreType(getStoreType(storeType));
        }

        emit(TruePassword());
      } else {
        emit(WrongPassword(message: "كلمه مرور غير صحيحه"));
      }
    } catch (e) {
      emit(CheckPasswordError(error: e.toString()));
    }
  }

  Future<void> checkAdminPassword(
      {required String password, required BuildContext context}) async {
    emit(CheckPasswordLoading());
    String phoneNumber = context.read<CustomerDataProvider>().phoneNumber!;
    final customerData = await FirebaseFirestore.instance
        .collection(UserRoleEnum.storeOwner.getCollectionName)
        .doc(phoneNumber)
        .get();
    final currentCustomerPassword = customerData['password'];
    if (currentCustomerPassword == password) {
      emit(TruePassword());
    } else {
      emit(WrongPassword(message: 'كلمه المرور غير صحيحه'));
    }
  }
}
