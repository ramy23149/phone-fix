class UserInfoModel {
  final String phone, name;
  final String district;

  UserInfoModel(
      { required this.phone, required this.name,required this.district});

  factory UserInfoModel.fromFirestore({
    required Map<String, dynamic> json,
    required bool newUser,
  }) {
    String phone = json['phone'];
    if (phone.startsWith('+20')) {
      phone = phone.substring(3);
    }
    return UserInfoModel(
      phone: phone,
      name: json['name'],
      district: json['district'],
    );
  }
}
