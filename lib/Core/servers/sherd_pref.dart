
import 'package:food_delivery_app/featurs/auth/data/enums/store_type_enum.dart';
import 'package:food_delivery_app/featurs/auth/data/enums/user_role_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SherdPrefHelper {
  static String userName = 'userName';
  static String userImage ='user_image_path';
  static String phoneNumber = 'phoneNumber';
  static String userRole = 'userRole';
  static String storeType = 'storeType';
  static String districte = 'districte';

  
  Future<bool> setPhoneNumber(String getPhoneNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(phoneNumber, getPhoneNumber);
  }

  Future<bool> setDistricte(String getDistricte) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(districte, getDistricte);
  }

 Future<bool> setStoreType(StoreTypeEnum getStoreType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(storeType, getStoreType.getDisplayName);
 }

  Future<bool> setRole(UserRoleEnum getRole) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userRole, getRole.getDisplayName);
  }

  Future<bool> setName(String? getUserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userName, getUserName??'');
  }


    Future<bool> setImage(String getUserImage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userImage, getUserImage);
  }

  //=============================separator====================================================//
  

  Future<String?> getPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(phoneNumber);
  }

  Future<String?> getDistricte() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(districte);
  }

  Future<String?> getStoreType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(storeType);
  }

  Future<String?> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userRole);
  }

  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userName);
  }

  Future<String?> getUserImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userImage);
  }

}



