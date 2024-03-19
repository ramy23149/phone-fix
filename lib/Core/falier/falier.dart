import 'package:dio/dio.dart';

abstract class Failer {
  final String errMasessge;

  Failer(this.errMasessge);
}

class ServerFailer extends Failer {
  ServerFailer(super.errMasessge);

  factory ServerFailer.fromDioExption(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailer('Conction timeout');
      case DioExceptionType.sendTimeout:
        return ServerFailer('send timeout');
      case DioExceptionType.receiveTimeout:
        return ServerFailer('receive timeout');
      case DioExceptionType.badCertificate:
        return ServerFailer('Bad Certificate');
      case DioExceptionType.badResponse:
        return ServerFailer.fromResponse(
            dioException.response!.statusCode!, dioException.response);
      case DioExceptionType.cancel:
        return ServerFailer('Response was canceled');
      case DioExceptionType.connectionError:
        return ServerFailer('No internet Connection');
      case DioExceptionType.unknown:
        if (dioException.message!.contains('SocketExceptoin')) {
          return ServerFailer('No internet Connection');
        }
        return ServerFailer('Unexpected Error, Please try again');
      default:
        return ServerFailer('Opps There was an error, Please try later');
    }
  }
  factory ServerFailer.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailer(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailer('Your request not found, Please try later');
    } else if (statusCode == 500) {
      return ServerFailer('Server Failer, Please try later');
    } else {
      return ServerFailer('Opps There was an error, Please try later');
    }
  }
}
