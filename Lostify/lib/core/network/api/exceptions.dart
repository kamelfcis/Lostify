import 'package:dio/dio.dart';

class ServerException implements Exception {
  final String errorMessage;

  ServerException({required this.errorMessage});
  @override
  String toString() => 'ServerException: $errorMessage';
}

void handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(errorMessage: "ERROR");
    case DioExceptionType.sendTimeout:
      throw ServerException(errorMessage: "ERROR");
    case DioExceptionType.receiveTimeout:
      throw ServerException(errorMessage: "ERROR");
    case DioExceptionType.badCertificate:
      throw ServerException(errorMessage: "ERROR");
    case DioExceptionType.cancel:
      throw ServerException(errorMessage: "ERROR");
    case DioExceptionType.connectionError:
      throw ServerException(errorMessage: "ERROR");
    case DioExceptionType.unknown:
      throw ServerException(errorMessage: "ERROR");
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400:
          throw ServerException(errorMessage: "ERROR");
        case 401:
        case 403:
          throw ServerException(errorMessage: "ERROR");
        case 404:
          throw ServerException(errorMessage: "ERROR");
        case 500:
          throw ServerException(errorMessage: "ERROR");
        case 502:
        case 503:
        case 504:
          throw ServerException(errorMessage: "ERROR");
        default:
          throw ServerException(errorMessage: "ERROR");
      }
  }
}
