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
}
