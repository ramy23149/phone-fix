import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/Core/servers/sherd_pref.dart';
import 'package:meta/meta.dart';

part 'check_password_state.dart';

class CheckPasswordCubit extends Cubit<CheckPasswordState> {
  CheckPasswordCubit() : super(CheckPasswordInitial());
  Future<void> checkPassowrd(DocumentSnapshot<Map<String, dynamic>> doc,String password)async{
    emit(CheckPasswordLoading());
    try{
      if(doc['password'] == password){
      await  SherdPrefHelper().setPhoneNumber(doc['phoneNumber']);
      await SherdPrefHelper().setUserName(doc['name']);
        emit(TruePassword());
      }else{
        emit(WrongPassword(
          message: "كلمه مرور غير صحيحه"
        ));
      }
    }catch(e){
      emit(CheckPasswordError(error:  e.toString()));
    }
  }
}
