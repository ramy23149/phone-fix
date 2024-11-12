class UserInfoModel {
  final String phone, name,district,password;
  final String image;

  UserInfoModel(
      {required this.password,required this.image, required this.phone, required this.name,required this.district});

  factory UserInfoModel.fromFirestore({
    required Map<String, dynamic> json,
  }) {
    String phone = json['phone'];
    if (phone.startsWith('+20')) {
      phone = phone.substring(3);
    }
    return UserInfoModel(
      password: json['password'],
      image: json['image'],
      phone: phone,
      name: json['name'],
      district: json['district'],
    );
  }
}
