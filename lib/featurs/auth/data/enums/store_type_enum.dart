enum StoreTypeEnum { phoneAccessories, phoneSpareParts }

extension StoreTypeExtention on StoreTypeEnum {
  String get getDisplayName {
    switch (this) {
      case StoreTypeEnum.phoneAccessories:
        return 'اكسسوارات';
      case StoreTypeEnum.phoneSpareParts:
        return 'قطع غيار';
    }
  }

  String get getCollectionName {
    switch (this) {
      case StoreTypeEnum.phoneAccessories:
        return "accessories";
      case StoreTypeEnum.phoneSpareParts:
        return "Phone spare parts";
    }
  }
}

StoreTypeEnum getStoreType(String type) {
  switch (type) {
    case 'اكسسوارات':
      return StoreTypeEnum.phoneAccessories;
    case 'قطع غيار':
      return StoreTypeEnum.phoneSpareParts;
    default:
      return StoreTypeEnum.phoneAccessories;
  }
}
