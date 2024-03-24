import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_delivery_app/Core/servers/data_base_methouds.dart';
import 'package:meta/meta.dart';

part 'add_items_state.dart';

class AddItemsCubit extends Cubit<AddItemsState> {
  AddItemsCubit() : super(AddItemsInitial());

  Future<void> addItem(File? image, String name, String price, String detalis,
      String categoryName) async {
    try {
      emit(AddItemsLoading());
      //String id = randomAlphaNumeric(10);
       await Future.delayed(Duration(seconds: 4));

      Reference ref =
          await FirebaseStorage.instance.ref().child('images').child('${DateTime.now()}');

      UploadTask uploadTask = ref.putFile(image?? File(''));

      var url = await (await uploadTask).ref.getDownloadURL();

      Map<String, dynamic> data = {
        'image': url,
        'name': name,
        'price': price,
        'detalis': detalis
      };

    await  DataBaseMethouds().addItem(data, categoryName);
    emit(AddItemsSuccess());
    } on FirebaseException catch (e) {
      print("Failed with error '${e.code}': ${e.message}");
      emit(AddItemsError());
    }
  }
}
