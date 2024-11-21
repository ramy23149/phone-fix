enum AccessoriesEnum{
  covers,
  phoneCharger,
  headPhone,
  somethingElse
}
extension AccessoriesExtention on AccessoriesEnum{
  String get getDisplayName{
    switch(this) {
      case AccessoriesEnum.covers:
       return "جراب موبايل";
      case AccessoriesEnum.phoneCharger:
       return 'شاحن';
      case AccessoriesEnum.headPhone:
       return "سماعة أذن";
      case AccessoriesEnum.somethingElse:
       return 'اخرى';
    }
  }
}