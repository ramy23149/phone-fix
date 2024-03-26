import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery_app/Core/servers/data_base_methouds.dart';
import 'package:meta/meta.dart';

part 'add_to_curt_state.dart';

class AddToCurtCubit extends Cubit<AddToCurtState> {
  AddToCurtCubit() : super(AddToCurtInitial());

  addToCurt(String name, int count, int totalPrice,String image) async {
    final Map<String, dynamic> addFoodToCurt = {
      'name': name,
      'quanter': count,
      'totalPrice': totalPrice,
      'image':image
    };
    final String id = FirebaseAuth.instance.currentUser!.uid;

    await DataBaseMethouds().addToCurt(addFoodToCurt, id);

    
    emit(AddToCurtSuccess());
  }
}
