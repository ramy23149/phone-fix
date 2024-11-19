import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/featurs/auth/data/enums/store_type_enum.dart';

import '../../../data/models/filter_model.dart';

class ConfirumFiltersProvider with ChangeNotifier {
  final FilterModel? filterModel;
  ConfirumFiltersProvider({required this.filterModel});
  List<DocumentSnapshot> searchResults = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;

  Future<void> search(String query) async {
    List<DocumentSnapshot> results = [];
    isLoading = true;
    notifyListeners();
    // Search in "Phone spare parts" collection
    QuerySnapshot phonePartsName = await FirebaseFirestore.instance
        .collection(StoreTypeEnum.phoneSpareParts.getCollectionName)
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    QuerySnapshot phonePartsDescription = await FirebaseFirestore.instance
        .collection(StoreTypeEnum.phoneSpareParts.getCollectionName)
        .where('detalis', isGreaterThanOrEqualTo: query)
        .where('detalis', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    QuerySnapshot phonePartsStores = await FirebaseFirestore.instance
        .collection(StoreTypeEnum.phoneSpareParts.getCollectionName)
        .where('storeInfo.name', isGreaterThanOrEqualTo: query)
        .where('storeInfo.name', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    results.addAll(phonePartsStores.docs);
    results.addAll(phonePartsName.docs);
    results.addAll(phonePartsDescription.docs);

    // Search in "accessories" collection
    QuerySnapshot accessoriesName = await FirebaseFirestore.instance
        .collection(StoreTypeEnum.phoneAccessories.getCollectionName)
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    QuerySnapshot accessoriesStores = await FirebaseFirestore.instance
        .collection(StoreTypeEnum.phoneAccessories.getCollectionName)
        .where('storeInfo.name', isGreaterThanOrEqualTo: query)
        .where('storeInfo.name', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    QuerySnapshot accessoriesDescription = await FirebaseFirestore.instance
        .collection(StoreTypeEnum.phoneAccessories.getCollectionName)
        .where('detalis', isGreaterThanOrEqualTo: query)
        .where('detalis', isLessThanOrEqualTo: query + '\uf8ff')
        .get();

    results.addAll(accessoriesStores.docs);
    results.addAll(accessoriesDescription.docs);
    results.addAll(accessoriesName.docs);

    // Remove duplicates based on document ID
    final uniqueResults =
        {for (var doc in results) doc.id: doc}.values.toList();

    searchResults = uniqueResults;

    isLoading = false;
    notifyListeners();
  }

  void clearSearchResults() {
    searchResults.clear();
    notifyListeners();
  }

  Future<void> confirmFilters() async {
    log("brand is ${filterModel?.brand} and categories is ${filterModel?.categories}");
    isLoading = true;
    notifyListeners();
    if (filterModel == null) {
      isLoading = false;
      return;
    } else if (filterModel!.brand == null && filterModel!.categories == null) {
      QuerySnapshot avilableAccessoriesInThisRange = await FirebaseFirestore
          .instance
          .collection(StoreTypeEnum.phoneAccessories.getCollectionName)
          .where('price', isGreaterThanOrEqualTo: filterModel!.minPrice)
          .where('price', isLessThanOrEqualTo: filterModel!.maxPrice)
          .get();
      searchResults.addAll(avilableAccessoriesInThisRange.docs);
    } else if (filterModel!.brand != null && filterModel!.categories != null) {
      QuerySnapshot avilableAccessoriesInThisRange = await FirebaseFirestore
          .instance
          .collection(StoreTypeEnum.phoneSpareParts.getCollectionName)
          .where('price', isGreaterThanOrEqualTo: filterModel!.minPrice)
          .where('price', isLessThanOrEqualTo: filterModel!.maxPrice)
          .where('brand', isEqualTo: filterModel!.brand)
          .where('type', whereIn: filterModel!.categories)
          .get();
      searchResults.addAll(avilableAccessoriesInThisRange.docs);
    }
    isLoading = false;
    notifyListeners();
  }
}
