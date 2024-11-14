import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_delivery_app/featurs/home/data/models/product_model.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';

import '../../../../../auth/data/enums/user_role_enum.dart';
import '../../providers/customer_data_provider.dart';

part 'add_to_curt_state.dart';

class AddToCurtCubit extends Cubit<AddToCurtState> {
  AddToCurtCubit() : super(AddToCurtInitial());

Future<void>  addToCurt({required ProductModel productModel,required int count,required int totalPrice,required BuildContext context}) async {
    emit(AddToCartLoading());
    final Map<String, dynamic> productData = {
      'name': productModel.name,
      'quanter': count,
      'totalPrice': totalPrice,
      'image': productModel.imageUrl,
      'date': DateTime.now(),
      'district': productModel.district,
      'type': productModel.type,
      'picePrice': productModel.price,
      'detalis': productModel.desc,
      'storeInfo': productModel.storeInfo,
    };

  final phoneNumber = context.read<CustomerDataProvider>().phoneNumber;
  final userRole = context.read<CustomerDataProvider>().userRole;
  if(userRole == UserRoleEnum.user.getDisplayName){
      await FirebaseFirestore.instance
        .collection(UserRoleEnum.user.getCollectionName)
        .doc(phoneNumber)
        .collection('curt')
        .add(productData);

  }else{
await FirebaseFirestore.instance
        .collection(UserRoleEnum.storeOwner.getCollectionName)
        .doc(phoneNumber)
        .collection('curt')
        .add(productData);

  }
  
    emit(AddToCurtSuccess());
  }
}
