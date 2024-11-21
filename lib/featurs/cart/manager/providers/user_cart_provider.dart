import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../Core/servers/data_base_methouds.dart';
import '../../../home/Presentation/Manager/providers/customer_data_provider.dart';
import '../../data/enums/payment_methoud_enum.dart';

class UserCartProvider extends ChangeNotifier {
  num totalCartPrice = 0;
  PaymentMethoudEnum? paymentMethoudEnum;
  Stream<QuerySnapshot<Object?>> getItems(BuildContext context) async* {
    yield* DataBaseMethouds().getCart(context);
  }

  Future<void> calculateCartTotalPrice(BuildContext context) async {
    totalCartPrice = 0;
    final userPhoneNumber = context.read<CustomerDataProvider>().phoneNumber;
    final userCart = await FirebaseFirestore.instance
        .collection('users')
        .doc(userPhoneNumber)
        .collection('curt')
        .get();
    if (userCart.docs.isEmpty) {
      totalCartPrice = 0;
    } else {
      for (var doc in userCart.docs) {
        totalCartPrice += doc['totalPrice'];
      }
    }

    notifyListeners();
  }

  Future<void> deleteFromCart(String id, BuildContext context) async {
    await DataBaseMethouds().deleteItemFromCurt(id, context);
    // ignore: use_build_context_synchronously
    await calculateCartTotalPrice(context);
  }

  
}
