enum SparePartsEnum { bettary, motherBord, phoneScreen, someThingElse }

extension SparePartsEnumExtention on SparePartsEnum {
  String get displayName {
    switch (this) {
      case SparePartsEnum.bettary:
        return "بطاريات";
      case SparePartsEnum.motherBord:
        return "بوردات";
      case SparePartsEnum.phoneScreen:
        return "شاشات";
      case SparePartsEnum.someThingElse:
        return "اخرى";
    }
  }
}
