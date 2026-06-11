abstract class ApiConsumer {
   Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  });
  Future<dynamic> post(
    String path, {
    Object? data,
    String? token,
    Map<String, dynamic>? queryParameters,
    bool isformdata = false,
  });
  Future<dynamic> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isformdata = false,
  });
  Future<dynamic> dalete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isformdata = false,
  });
  Future<dynamic> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isformdata = false,
  });
}
