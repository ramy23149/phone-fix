import 'package:dartz/dartz.dart';
import 'package:food_delivery_app/Core/falier/falier.dart';

abstract class WalletRepo {
  Future<Either<Failer, String>> makePayment(int amount, String currency);
  Future<void> initPaymentSheet(String clientSecret);
}
