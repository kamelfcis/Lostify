import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lostify/core/network/api/api_consumer.dart';

class HttpConsumer extends ApiConsumer {
  final String baseUrl;

  HttpConsumer({required this.baseUrl});

  HttpClient _getHttpClient() {
    HttpClient client = HttpClient();
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  }

Future<dynamic> _sendRequest(
  String method,
  String path, {
  String? token,
  Object? data,
  Map<String, dynamic>? queryParameters,
  bool isFormData = false,  // إضافة هذا البراميتر
}) async {
  try {
    final httpClient = _getHttpClient();
    final uri = Uri.parse(baseUrl + path).replace(queryParameters: queryParameters);
    late HttpClientRequest request;

    switch (method.toUpperCase()) {
      case 'GET':
        request = await httpClient.getUrl(uri);
        break;
      case 'POST':
        request = await httpClient.postUrl(uri);
        break;
      case 'PATCH':
        request = await httpClient.patchUrl(uri);
        break;
      case 'DELETE':
        request = await httpClient.deleteUrl(uri);
        break;
      case 'PUT':
        request = await httpClient.putUrl(uri);
        break;
      default:
        throw ServerException(errorMessage: 'Unsupported method $method');
    }

    if (token != null) {
      request.headers.set('Authorization', 'Bearer $token');
    }

    if (data != null) {
      if (isFormData && data is Map<String, dynamic> && data.containsKey('image')) {
        // إرسال Multipart
        final boundary = '----dart-http-boundary-${DateTime.now().millisecondsSinceEpoch}';
        request.headers.set(HttpHeaders.contentTypeHeader, 'multipart/form-data; boundary=$boundary');

        final imageFile = data['image'] as File;
        final otherFields = Map.of(data);
        otherFields.remove('image');

        // بناء الـ multipart body:
        final body = StringBuffer();

        // إضافة حقول نصية
        otherFields.forEach((key, value) {
          body.write('--$boundary\r\n');
          body.write('Content-Disposition: form-data; name="$key"\r\n\r\n');
          body.write('$value\r\n');
        });

        // إضافة الصورة
        final imageBytes = await imageFile.readAsBytes();
        final imageName = imageFile.path.split('/').last;

        body.write('--$boundary\r\n');
        body.write('Content-Disposition: form-data; name="image"; filename="$imageName"\r\n');
        body.write('Content-Type: image/jpeg\r\n\r\n');

        // نحتاج نرسل body ك bytes مع الصورة، لا يمكن إضافتها مباشرة ك string
        final bodyString = body.toString();
        final bodyBytes = utf8.encode(bodyString) + imageBytes + utf8.encode('\r\n--$boundary--\r\n');

        request.add(bodyBytes);
      } else {
        // إرسال JSON
        request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
        request.add(utf8.encode(jsonEncode(data)));
      }
    }

    final response = await request.close();
    final responseBody = await response.transform(utf8.decoder).join();

    return _handleResponse(response.statusCode, responseBody);
  } catch (e) {
    throw ServerException(errorMessage: e.toString());
  }
}

  @override
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) {
    return _sendRequest(
      'GET',
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }

@override
Future<dynamic> post(
  String path, {
  String? token,
  Object? data,
  Map<String, dynamic>? queryParameters,
  bool isformdata = false,
}) {
  return _sendRequest(
    'POST',
    path,
    token: token,
    data: data,
    queryParameters: queryParameters,
    isFormData: isformdata,
  );
}

  @override
  Future<dynamic> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isformdata = false,
  }) {
    return _sendRequest(
      'PATCH',
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }

  @override
  Future<dynamic> dalete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isformdata = false,
  }) {
    return _sendRequest(
      'DELETE',
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }

  @override
  Future<dynamic> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isformdata = false,
  }) {
    return _sendRequest(
      'PUT',
      path,
      data: data,
      queryParameters: queryParameters,
    );
  }

  dynamic _handleResponse(int statusCode, String responseBody) {
    if (statusCode >= 200 && statusCode < 300) {
      return jsonDecode(responseBody);
    } else {
      throw ServerException(errorMessage: responseBody);
    }
  }
}

class ServerException implements Exception {
  final String errorMessage;
  ServerException({required this.errorMessage});

  @override
  String toString() => errorMessage;
}

void handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.badCertificate:
    case DioExceptionType.cancel:
    case DioExceptionType.connectionError:
    case DioExceptionType.unknown:
      throw ServerException(errorMessage: e.toString());
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400:
        case 401:
        case 403:
        case 404:
        case 500:
        case 502:
        case 503:
        case 504:
          throw ServerException(errorMessage: e.toString());
        default:
          throw ServerException(errorMessage: e.toString());
      }
  }
}
