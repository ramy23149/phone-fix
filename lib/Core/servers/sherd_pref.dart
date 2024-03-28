
import 'package:shared_preferences/shared_preferences.dart';

class SherdPrefHelper {
  static String userEmail = 'userEmail';
  static String userName = 'userName';
  static String userUID = 'userUID';
  static String userWallet = 'userWallet';
  static String userImage ='user_image_path';

  Future<bool> setUserEmail(String getUserEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmail, getUserEmail);
  }

  Future<bool> setUserName(String getUserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userName, getUserName);
  }

  Future<bool> setUserUID(String getUserUID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userUID, getUserUID);
  }

  Future<bool> setUserWallet(int getUserWallet) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(userWallet, getUserWallet);
  }

    Future<bool> setUserImage(String getUserImage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userImage, getUserImage);
  }

  //=================================================================
  Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmail);
  }

  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userName);
  }

  Future<String?> getUserUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userUID);
  }

  Future<int?> getUserWallet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(userWallet);
  }

  Future<String?> getUserImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userImage);
  }

}



