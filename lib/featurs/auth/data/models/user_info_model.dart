class UserInfoModel {
  final String phone, name;
  final bool newUser;
  final String district;

  UserInfoModel(
      {required this.newUser, required this.phone, required this.name,required this.district});

  factory UserInfoModel.fromFirestore({
    required Map<String, dynamic> json,
    required bool newUser,
  }) {
    String phone = json['phone'];
    if (phone.startsWith('+20')) {
      phone = phone.substring(3);
    }
    return UserInfoModel(
      newUser: newUser,
      phone: phone,
      name: json['name'],
      district: json['district'],
    );
  }
}
