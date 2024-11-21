import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Core/servers/data_base_methouds.dart';
import '../../../home/Presentation/Manager/providers/customer_data_provider.dart';

class UserCartProvider extends ChangeNotifier {
  num totalCartPrice = 0;
  Stream<QuerySnapshot<Object?>> getItems(BuildContext context) async* {
    yield* DataBaseMethouds().getCart(context);
  }


  Future<void> calculateCartTotalPrice(BuildContext context) async {
    final userPhoneNumber = context.read<CustomerDataProvider>().phoneNumber;
    final userCart = await FirebaseFirestore.instance.collection('users').doc(userPhoneNumber).collection('curt').get();
    for (var doc in userCart.docs) {
      totalCartPrice += doc['totalPrice'];
    }
    notifyListeners();
  }
}