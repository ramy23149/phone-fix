import 'package:dartz/dartz.dart';
import 'package:food_delivery_app/featurs/auth/data/models/store_info_model.dart';

import 'user_info_model.dart';

class VerificatoinDataModel {
  final Either<UserInfoModel, StoreInfoModel>? data;
  final bool isForgotPasswordCase;
  final String phone;
  final bool isNew;

  VerificatoinDataModel(
      {required this.data,
      required this.isForgotPasswordCase,
      required this.phone,
      required this.isNew});
}
