import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/featurs/cart/manager/providers/user_cart_provider.dart';
import 'package:meta/meta.dart';

import '../../../home/Presentation/Manager/providers/customer_data_provider.dart';
import '../../data/enums/payment_methoud_enum.dart';

part 'confirm_order_state.dart';

class ConfirmOrderCubit extends Cubit<ConfirmOrderState> {
  ConfirmOrderCubit() : super(ConfirmOrderInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> confirmOrder(BuildContext context) async {
    emit(ConfirmOrderLoading());

    final userPhoneNumber = context.read<CustomerDataProvider>().phoneNumber;
    final PaymentMethoudEnum? paymentMethod =
        context.read<UserCartProvider>().paymentMethoudEnum;

    if (paymentMethod == null) {
      emit(ConfirmOrderError("لم يتم اختيار طريقه الدفع"));
      return;
    }

    try {
      final cartRef = _firestore
          .collection('users')
          .doc(userPhoneNumber)
          .collection('curt');

      final cartItems = await cartRef.get();

      if (cartItems.docs.isEmpty) {
        emit(ConfirmOrderError("يبدو ان عربه التسوق الخاصه بك فارغه"));
        return;
      }

      List<Map<String, dynamic>> purchaseItems = [];
      String storePhoneNumber = "";
      num totalPrice = 0;

      for (var item in cartItems.docs) {
        final data = item.data();
        purchaseItems.add(data);

        totalPrice += data['picePrice'] * data['quanter'];

        storePhoneNumber = data['storeInfo']['phoneNumber'] ?? "";
      }

      if (storePhoneNumber.isEmpty) {
        emit(
            ConfirmOrderError("لم يتم العثور على المتجر في عناصر عربة التسوق"));
        return;
      }

      final orderData = {
        'userId': userPhoneNumber,
        'paymentMethod':
            paymentMethod.toString().split('.').last,
        'items': purchaseItems,
        'totalPrice': totalPrice,
        'date': FieldValue.serverTimestamp(),
      };

      await _firestore.collection('Purchases').doc().set(orderData);

      final userPurchasesRef = _firestore
          .collection('users')
          .doc(userPhoneNumber)
          .collection('Purchases');
      await userPurchasesRef.doc().set(orderData);

      final storeOrdersRef = _firestore
          .collection('stores')
          .doc(storePhoneNumber)
          .collection('orders');
      await storeOrdersRef.doc().set(orderData);

      for (var item in cartItems.docs) {
        await cartRef.doc(item.id).delete();
      }

      emit(ConfirmOrderSuccess());
    } catch (e) {
      emit(ConfirmOrderError("Failed to confirm order: $e"));
      log(e.toString());
    }
  }
}
