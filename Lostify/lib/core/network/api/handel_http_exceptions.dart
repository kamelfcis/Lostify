class BadRequestException implements Exception {
  final String message;
  BadRequestException(this.message);
  @override
  String toString() => 'Bad Request: $message';
}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException(this.message);
  @override
  String toString() => 'Unauthorized: $message';
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException(this.message);
  @override
  String toString() => 'Not Found: $message';
}

class InternalServerErrorException implements Exception {
  final String message;
  InternalServerErrorException(this.message);
  @override
  String toString() => 'Server Error: $message';
}

class FetchDataException implements Exception {
  final String message;
  FetchDataException(this.message);
  @override
  String toString() => 'Fetch Data Error: $message';
}

Exception handleHttpExceptions(int statusCode, dynamic responseBody) {
  switch (statusCode) {
    case 400:
      return BadRequestException(responseBody.toString());
    case 401:
    case 403:
      return UnauthorizedException(responseBody.toString());
    case 404:
      return NotFoundException(responseBody.toString());
    case 500:
      return InternalServerErrorException(responseBody.toString());
    default:
      return FetchDataException(
        'Error occurred while Communication with Server with StatusCode: $statusCode\nBody: $responseBody',
      );
  }
}
