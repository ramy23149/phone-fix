import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());

  Future<void> loginAdmin(
      {required String userName, required String password}) async {
    emit(AdminLoading());
    FirebaseFirestore.instance.collection('admin').get().then((snapshot) {
      snapshot.docs.forEach((element) {
        if (element.data()['id'] != userName) {
          emit(AdminWrongId());
        }else if(element.data()['password'] !=password){
          emit(AdminWrongPassword());
        }else if(element.data()['id'] == userName && element.data()['password'] == password){
          emit(AdminLoginSuccess());
        }
      });
    });
  }
}
