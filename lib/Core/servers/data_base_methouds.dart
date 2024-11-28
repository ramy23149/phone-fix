import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/featurs/home/Presentation/Manager/providers/customer_data_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../featurs/auth/data/enums/user_role_enum.dart';

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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> deleteUser(
      {required String userRole, required String phoneNumber}) async {
    String collectionName = userRole == UserRoleEnum.user.getDisplayName
        ? UserRoleEnum.user.getCollectionName
        : UserRoleEnum.storeOwner.getCollectionName;
    final docRef =
        FirebaseFirestore.instance.collection(collectionName).doc(phoneNumber);
    if (userRole == UserRoleEnum.user.getDisplayName) {
      final subCollectoin = await docRef.collection('Purchases').get();
      final subCollectoin2 = await docRef.collection('curt').get();
    if (subCollectoin.docs.isNotEmpty || subCollectoin2.docs.isNotEmpty) {
        if (subCollectoin.docs.isNotEmpty) {
          for (var doc in subCollectoin.docs) {
            await doc.reference.delete();
          }
        }

        if (subCollectoin2.docs.isNotEmpty) {
          for (var doc in subCollectoin2.docs) {
            await doc.reference.delete();
          }
        }

        await docRef.delete();
      }
    } else {
      final subCollectoin = await docRef.collection('products').get();
      final subCollectoin2 = await docRef.collection('orders').get();
      if (subCollectoin.docs.isNotEmpty || subCollectoin2.docs.isNotEmpty) {
        if (subCollectoin.docs.isNotEmpty) {
          for (var doc in subCollectoin.docs) {
            await doc.reference.delete();
          }
        }

        if (subCollectoin2.docs.isNotEmpty) {
          for (var doc in subCollectoin2.docs) {
            await doc.reference.delete();
          }
        }

        await docRef.delete();
      }
    }
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.currentUser!.delete();
    } else {
      await FirebaseAuth.instance.signOut();
    }
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

  Future deleteItemFromCurt(String id, BuildContext context) async {
    String? phoneNumber = context.read<CustomerDataProvider>().phoneNumber;
    FirebaseFirestore.instance
        .collection('users')
        .doc(phoneNumber)
        .collection('curt')
        .doc(id)
        .delete();
  }
}
