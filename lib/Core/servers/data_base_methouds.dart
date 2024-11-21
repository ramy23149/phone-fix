import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/featurs/home/Presentation/Manager/providers/customer_data_provider.dart';

class DataBaseMethouds {
  Future addUserDetails(Map<String, dynamic> userData, String uId) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userData);
  }

  Future addItem(Map<String, dynamic> userData, String name) async {
    return await FirebaseFirestore.instance.collection(name).add(userData);
  }

  Future<Stream<QuerySnapshot>> getItems(String name) async {
    return FirebaseFirestore.instance.collection(name).snapshots();
  }


  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> deleteUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .delete();
    await FirebaseAuth.instance.currentUser!.delete();
  }

  Stream<QuerySnapshot> getCart(BuildContext context) async* {
    yield* FirebaseFirestore.instance
        .collection('users')
        .doc(context.read<CustomerDataProvider>().phoneNumber)
        .collection('curt')
        .orderBy('date', descending: true)
        .snapshots();
  }

  Future deleteCurt(String uId) async {
    CollectionReference collection = FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('curt');

    await collection.get().then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
  }

  Future deleteItemFromCurt(String id,BuildContext context) async {
    String? phoneNumber = context.read<CustomerDataProvider>().phoneNumber;
      FirebaseFirestore.instance
        .collection('users')
        .doc(phoneNumber)
        .collection('curt').doc(id).delete();
  
  }

}
