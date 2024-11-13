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
       return "جرابات";
      case AccessoriesEnum.phoneCharger:
       return 'شارجات';
      case AccessoriesEnum.headPhone:
       return 'هيدفون';
      case AccessoriesEnum.somethingElse:
       return 'اخرى';
    }
  }
}