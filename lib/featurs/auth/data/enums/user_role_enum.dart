enum UserRoleEnum { user, storeOwner }

extension UserRoleExtention on UserRoleEnum{
  String get getDisplayName{
    switch(this) {
      case UserRoleEnum.storeOwner:
       return 'صاحب محل';
      case UserRoleEnum.user:
      return 'مستخدم';
    }
  }
}
