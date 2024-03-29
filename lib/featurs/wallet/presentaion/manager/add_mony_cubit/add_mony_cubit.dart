import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/servers/sherd_pref.dart';
import 'package:food_delivery_app/featurs/wallet/data/repos/wallet/wallet_repo.dart';
import 'package:food_delivery_app/featurs/wallet/presentaion/manager/add_mony_cubit/add_mony_state.dart';

import '../../../../../Core/helper/Costom_alert_dialog.dart';

class AddMonyCubit extends Cubit<AddMonyState> {
  AddMonyCubit(this.walletRepo) : super(AddMonyInitial());
  final WalletRepo walletRepo;

  Future<void> addMony(int amount, BuildContext context) async {
    emit(AddMonyLoading());
    var result = await walletRepo.makePayment(amount, 'USD');
    var documentId = FirebaseAuth.instance.currentUser!.uid;
 
    result.fold(
      (falier) => emit(AddMonyFailure(falier.errMasessge)),
      (r)async {
      
        var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(documentId)
        .get();
        var currentWallet = snapshot.data()!['Wallet'] ?? 0;
        var newWalletBalance= currentWallet + amount;


    FirebaseFirestore.instance
        .collection('users')
        .doc(documentId)
        .update(
      {
        'Wallet': newWalletBalance
      },
    );
    SherdPrefHelper().setUserWallet(newWalletBalance);
  emit(AddMonySuccess());
        showAlertDialog(context, "Your payment was successful.",const Icon(Icons.done_outline_rounded),Colors.green);
      },
    );
  }
}
