import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery_app/Core/api_service.dart';

import '../../../../../Core/falier/falier.dart';
import 'wallet_repo.dart';

class WalletRepoImple implements WalletRepo {
final  ApiService apiService;

  WalletRepoImple(this.apiService);

  @override
  Future<Either<Failer, String>> makePayment(int amount, String currency)async {
    try {
      var clientSecret = await apiService.post(amount: (amount*100), currency: currency);
    await  initPaymentSheet(clientSecret);
    await Stripe.instance.presentPaymentSheet();
      return right(clientSecret);
    }  catch (e) {
     if(e is DioException){
       return left(ServerFailer.fromDioExption(e));
     }
     else{
       return left(ServerFailer(e.toString()));
     }
    }
  }
  
  @override
  Future<void> initPaymentSheet(String clientSecret)async {
   await Stripe.instance.initPaymentSheet(
    paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: clientSecret,
      merchantDisplayName: 'Ramy',
    ));
  }
}
