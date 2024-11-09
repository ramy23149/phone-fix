import 'package:flutter/material.dart';
import 'package:food_delivery_app/featurs/auth/data/enums/user_role_enum.dart';

class AuthUserProvider extends ChangeNotifier {
  UserRoleEnum? userRoleEnum;

  set userRole(UserRoleEnum? value) {
    if (value != null) {
      userRoleEnum = value;
    }
  }

  UserRoleEnum? get userRole {
    if(userRoleEnum==null){
      return UserRoleEnum.user;
    }else{
      return userRoleEnum;
    }
  }
}
