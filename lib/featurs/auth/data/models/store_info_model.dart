import '../enums/store_type_enum.dart';

class StoreInfoModel {
  final String storeName;
  final String storeAddress;
  final String storePhoneNumber;
  final String storeLogoUrl;
  final StoreTypeEnum storeType;

  StoreInfoModel({
    required this.storeName,
    required this.storeAddress,
    required this.storePhoneNumber,
    required this.storeLogoUrl,
    required this.storeType,
  });

  factory StoreInfoModel.fromJson(Map<String, dynamic> json) {
    return StoreInfoModel(
      storeName: json['storeName'],
      storeAddress: json['storeAddress'],
      storePhoneNumber: json['storePhoneNumber'],
      storeLogoUrl: json['storeLogoUrl'],
      storeType: StoreTypeEnum.values[json['storeType']],
    );
  }
}