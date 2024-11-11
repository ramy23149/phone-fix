import '../enums/user_role_enum.dart';

class UpdatePassowrdModel {
  final String phoneNumber;
  final UserRoleEnum userRole;
   
  UpdatePassowrdModel({
    required this.phoneNumber,
    required this.userRole,
  });
}