import 'package:flutter/material.dart';

import '../../../../../Core/servers/sherd_pref.dart';

class CustomerDataProvider with ChangeNotifier {
  String? name;
  String? image;
  String? phoneNumber;
  String? userRole;
  String? storeType;
  String? districte;

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
