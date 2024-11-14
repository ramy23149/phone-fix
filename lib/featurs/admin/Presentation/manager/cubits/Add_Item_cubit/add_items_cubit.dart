import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/servers/data_base_methouds.dart';
import 'package:food_delivery_app/featurs/admin/data/models/uploaded_product_model.dart';
import 'package:food_delivery_app/featurs/auth/data/enums/store_type_enum.dart';
import 'package:food_delivery_app/featurs/auth/data/enums/user_role_enum.dart';
import 'package:food_delivery_app/featurs/home/Presentation/Manager/providers/customer_data_provider.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

part 'add_items_state.dart';

class AddItemsCubit extends Cubit<AddItemsState> {
  AddItemsCubit() : super(AddItemsInitial());

  Future<void> addItem(
      UploadedProductModel productModel, BuildContext context) async {
    try {
      emit(AddItemsLoading());
      //String id = randomAlphaNumeric(10);
      //await Future.delayed(Duration(seconds: 4));
      String categoryName = 'accessories';
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('images')
          .child('${DateTime.now()}');

      UploadTask uploadTask = ref.putFile(productModel.image);

      var url = await (await uploadTask).ref.getDownloadURL();

      final storeInfoDoc = await FirebaseFirestore.instance
          .collection('stores')
          .doc(context.read<CustomerDataProvider>().phoneNumber)
          .get();

      Map<String, dynamic> data = {
        'image': url,
        'name': productModel.name,
        'price': productModel.price,
        'detalis': productModel.desc,
        'district': context.read<CustomerDataProvider>().districte,
        'type': getCategoryName(
            productModel.subCategory, isAccessoriesStore(context)),
        'storeInfo': {
          'name': storeInfoDoc['name'],
          'phoneNumber': storeInfoDoc['phoneNumber'],
          'image': storeInfoDoc['image'],
          'districte': storeInfoDoc['district'],
          'type': storeInfoDoc['type'],
        }
      };
      if (storeInfoDoc['type'] ==
          StoreTypeEnum.phoneAccessories.getDisplayName) {
        categoryName = 'accessories';
      } else {
        categoryName = 'Phone spare parts';
      }
      await DataBaseMethouds().addItem(data, categoryName);
      data.remove('storeInfo');
      await FirebaseFirestore.instance
          .collection(UserRoleEnum.storeOwner.getCollectionName)
          .doc(storeInfoDoc['phoneNumber'])
          .collection("products")
          .add(data);
      emit(AddItemsSuccess());
    } on FirebaseException catch (e) {
      print("Failed with error '${e.code}': ${e.message}");
      emit(AddItemsError());
    }
  }

  bool isAccessoriesStore(BuildContext context) {
    final storeTypeEnum = context.read<CustomerDataProvider>().storeType;
    if (storeTypeEnum == StoreTypeEnum.phoneAccessories.getDisplayName) {
      return true;
    } else {
      return false;
    }
  }

  String getCategoryName(String enumName, bool isAccessories) {
    if (isAccessories) {
      switch (enumName) {
        case 'covers':
          return 'جرابات';
        case 'phoneCharger':
          return 'شارجات';
        case 'headPhone':
          return 'هيدفون';
        case 'somethingElse':
          return 'اخرى';
        default:
          return '';
      }
    } else {
      switch (enumName) {
        case 'bettary':
          return 'بطاريات';
        case 'motherBord':
          return 'بوردات';
        case 'phoneScreen':
          return 'شاشات';
        case 'someThingElse':
          return 'اخرى';
        default:
          return '';
      }
    }
  }
}
