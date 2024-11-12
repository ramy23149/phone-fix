import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/Core/servers/sherd_pref.dart';
import 'package:meta/meta.dart';

import '../../../../data/enums/user_role_enum.dart';

part 'update_password_state.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  UpdatePasswordCubit() : super(UpdatePasswordInitial());

  Future<void> updatePassword(
      {required String phoneNumber,
      required UserRoleEnum userRole,
      required String password}) async {
    emit(UpdatePasswordLoading());
    try {
      if (userRole == UserRoleEnum.user) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc("+20$phoneNumber")
            .update({'password': password});
      } else {
        await FirebaseFirestore.instance
            .collection('stores')
            .doc("+20$phoneNumber")
            .update({'password': password});
      }
      await SherdPrefHelper().setPhoneNumber("+20$phoneNumber");
      emit(UpdatePasswordSuccess());
    } catch (e) {
      emit(UpdatePasswordError(error: e.toString()));
    }
  }
}
