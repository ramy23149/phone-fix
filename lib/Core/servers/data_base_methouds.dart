import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethouds {
  Future addUserDetails(Map<String, dynamic> userData, String uId) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userData);
  }

  Future addItem(Map<String, dynamic> userData, String name) async {
    return await FirebaseFirestore.instance
        .collection(name).add(userData);
        
  }
}
