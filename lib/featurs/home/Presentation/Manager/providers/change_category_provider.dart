import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/Core/app_router.dart';
import 'package:food_delivery_app/Core/constats.dart';
import 'package:food_delivery_app/Core/helper/custom_delightFul_toast.dart';
import 'package:food_delivery_app/featurs/auth/data/enums/store_type_enum.dart';
import 'package:food_delivery_app/featurs/home/Presentation/Manager/providers/customer_data_provider.dart';
import 'package:food_delivery_app/featurs/home/data/enums/accessories_enum.dart';
import 'package:food_delivery_app/featurs/home/data/enums/spare_parts_enum.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/models/filter_model.dart';

class ChangeCategoryProvider with ChangeNotifier {
  int selectedKey = 0;

  List<String> selectedSparePartsSubCategorys = [];

  Color dropDownColor = kMainAppColor;

  StoreTypeEnum storeType = StoreTypeEnum.phoneAccessories;

  void selectCategory(String category) {
    if (selectedSparePartsSubCategorys.contains(category)) {
      selectedSparePartsSubCategorys.remove(category);
    } else {
      selectedSparePartsSubCategorys.add(category);
    }
  }

  Future<QuerySnapshot> neriestProductsQuery(
      {required BuildContext context,
      required bool showTheNearestPlaces}) async {
    final curuntCostumerPlace = context.read<CustomerDataProvider>().districte;
    List<String> categoriesList = [];
    if (storeType == StoreTypeEnum.phoneAccessories) {
      categoriesList = phoneAccessoriesTypes;
    } else {
      categoriesList = phoneSparePartsTypes;
    }
    if (showTheNearestPlaces) {
      return FirebaseFirestore.instance
          .collection(storeType.getCollectionName)
          .where('storeInfo.districte', isEqualTo: curuntCostumerPlace)
          .where('type', isEqualTo: categoriesList[selectedKey])
          .get();
    } else {
      return FirebaseFirestore.instance
          .collection(storeType.getCollectionName)
          .where('type', isEqualTo: categoriesList[selectedKey])
          .get();
    }
  }

  //final curuntUserPlace =

//  Future<QuerySnapshot> neriestProductsQuery = FirebaseFirestore.instance.collection(storeType.getDisplayName).where('').get();

  List<String> phoneAccessoriesTypes = [
    AccessoriesEnum.covers.getDisplayName,
    AccessoriesEnum.headPhone.getDisplayName,
    AccessoriesEnum.phoneCharger.getDisplayName,
    AccessoriesEnum.somethingElse.getDisplayName
  ];

  List<String> phoneSparePartsTypes = [
    SparePartsEnum.phoneScreen.displayName,
    SparePartsEnum.bettary.displayName,
    SparePartsEnum.motherBord.displayName,
    SparePartsEnum.someThingElse.displayName
  ];

  List<String> phoneAccessoriesImages = [
    'assets/images/covers.png',
    'assets/images/head_phone.png',
    'assets/images/phone_charger.png',
    'assets/images/genral_phone_accessories.webp'
  ];
  List<String> phoneSparePartsImages = [
    'assets/images/display.png',
    'assets/images/phone_bettary.jpg',
    'assets/images/mother_bord.png',
    'assets/images/genral_phone_spart_parts.png',
  ];

  void changeCategorys(int index) {
    if (index == 0) {
      storeType = StoreTypeEnum.phoneAccessories;
    } else {
      storeType = StoreTypeEnum.phoneSpareParts;
    }
    notifyListeners();
  }

  void selectKey(int key) {
    selectedKey = key;
    notifyListeners();
  }

  bool isSelected(int key) {
    return selectedKey == key;
  }

  void hanleFiltieringProcess(
      {required String brand,
      required BuildContext context,
      required int minPrice,
      required int maxPrice}) {
    if (storeType == StoreTypeEnum.phoneAccessories) {
      context.push(AppRouter.kSearchView,
          extra: FilterModel(
              maxPrice: maxPrice,
              minPrice: minPrice,
              brand: null,
              categories: null));
    } else if (selectedSparePartsSubCategorys.isNotEmpty &&
        brand != "حدد نوع هاتفك") {
      context.push(AppRouter.kSearchView,
          extra: FilterModel(
              maxPrice: maxPrice,
              minPrice: minPrice,
              brand: brand,
              categories: selectedSparePartsSubCategorys));
    } else if (selectedSparePartsSubCategorys.isEmpty) {
      showDelightfulToast(message: "برجاء اختيار نوع المنتج", context: context);
    } else if (brand == "حدد نوع هاتفك") {
      dropDownColor = Colors.red;
      showDelightfulToast(message: 'حدد نوع هاتفك', context: context);
    }
  }
}
