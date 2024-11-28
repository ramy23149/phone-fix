import 'package:flutter/material.dart';

import '../../../../../Core/servers/sherd_pref.dart';

class CustomerDataProvider with ChangeNotifier {
  String? name;
  String? image;
  String? phoneNumber;
  String? userRole;
  String? storeType;
  String? districte;
  void resetCustomerData() {
    name = null;
    image = null;
    phoneNumber = null;
    userRole = null;
    storeType = null;
    districte = null;
  //  notifyListeners();
  }

  Future<void> fetchCustomerData() async {
    name = await SherdPrefHelper().getUserName();
    image = await SherdPrefHelper().getUserImage();
    phoneNumber = await SherdPrefHelper().getPhoneNumber();
    userRole = await SherdPrefHelper().getUserRole();
    storeType = await SherdPrefHelper().getStoreType();
    districte = await SherdPrefHelper().getDistricte();
    notifyListeners();
  }
}
