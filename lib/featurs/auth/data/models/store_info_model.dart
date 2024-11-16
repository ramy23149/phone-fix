import 'dart:io';

import '../enums/store_type_enum.dart';

class StoreInfoModel {
  final String storeName;
  final String storeAddress;
  final String storePhoneNumber;
  final File storeLogoUrl;
  final String password;
  final StoreTypeEnum storeType;

  StoreInfoModel({
    required this.password,
    required this.storeName,
    required this.storeAddress,
    required this.storePhoneNumber,
    required this.storeLogoUrl,
    required this.storeType,
  });

  factory StoreInfoModel.fromJson(Map<String, dynamic> json) {
    return StoreInfoModel(
      password: json['password'],
      storeName: json['storeName'],
      storeAddress: json['storeAddress'],
      storePhoneNumber: json['storePhoneNumber'],
      storeLogoUrl: json['storeLogoUrl'],
      storeType: StoreTypeEnum.values[json['storeType']],
    );
  }
}
