enum SparePartsEnum { bettary, motherBord, phoneScreen, someThingElse }
enum SparePartsBrandsEnum {
samsung,
apple,
xiaomi,
huawei,
oppo,
vivo,
onePlus,
realme,
sony,
googlePixel,
nokia,
motorola,
lg}
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

extension SparePartsBrandsExtention on SparePartsBrandsEnum {
  String get displayName {
    switch (this) {
      case SparePartsBrandsEnum.samsung:
        return "Samsung";
      case SparePartsBrandsEnum.apple:
        return "Apple";
      case SparePartsBrandsEnum.xiaomi:
        return "Xiaomi";
      case SparePartsBrandsEnum.huawei:
        return "Huawei";
      case SparePartsBrandsEnum.oppo:
        return "Oppo";
      case SparePartsBrandsEnum.vivo:
        return "Vivo";
      case SparePartsBrandsEnum.onePlus:
        return "OnePlus";
      case SparePartsBrandsEnum.realme:
        return "Realme";
      case SparePartsBrandsEnum.sony:
        return "Sony";
      case SparePartsBrandsEnum.googlePixel:
        return "Google Pixel";
      case SparePartsBrandsEnum.nokia:
        return "Nokia";
      case SparePartsBrandsEnum.motorola:
        return "Motorola";
      case SparePartsBrandsEnum.lg:
        return "LG";
    }
  }
}
