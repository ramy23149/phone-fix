import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../../featurs/cart/data/repos/payment_repos/payment_repo_imple.dart';
import '../../featurs/cart/manager/card_payment_cubit/card_payment_cubit.dart';
import '../api_service.dart';


final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Dio());

  locator.registerLazySingleton(() => ApiService(locator<Dio>()));

  locator.registerLazySingleton(() => WalletRepoImple(locator<ApiService>()));

  locator.registerFactory(() => CardPaymentCubit(locator<WalletRepoImple>()));
}
