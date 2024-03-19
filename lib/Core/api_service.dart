import 'package:dio/dio.dart';
import 'package:food_delivery_app/Core/constats.dart';

class ApiService {
  ApiService(this._dio);

  final Dio _dio;

  final _baseUrl = 'https://api.stripe.com//v1/payment_intents';
  Future<String> post({required int amount, required String currency}) async {
    Response response = await _dio.post('$_baseUrl',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${kSecretkey}',
            'Content-Type': 'application/x-www-form-urlencoded',
          }
        ),
        data: {
          'amount': amount,
          'currency':currency,
        }
    );
    return response.data['client_secret'];

  }
}
