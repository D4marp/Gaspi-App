/// Base class untuk semua exception di aplikasi
class AppException implements Exception {
  final String message;
  final dynamic data;

  AppException(this.message, [this.data]);

  @override
  String toString() => message;
}

/// Exception untuk network error
class NetworkException extends AppException {
  NetworkException(super.message);
}

/// Exception untuk 400 Bad Request
class BadRequestException extends AppException {
  BadRequestException(super.message);
}

/// Exception untuk 401 Unauthorized
class UnauthorizedException extends AppException {
  UnauthorizedException(super.message);
}

/// Exception untuk 403 Forbidden
class ForbiddenException extends AppException {
  ForbiddenException(super.message);
}

/// Exception untuk 404 Not Found
class NotFoundException extends AppException {
  NotFoundException(super.message);
}

/// Exception untuk 422 Validation Error
class ValidationException extends AppException {
  ValidationException(String message, [dynamic data]) : super(message, data);

  Map<String, dynamic>? get errors {
    if (data is Map) {
      return (data as Map)['errors'] as Map<String, dynamic>?;
    }
    return null;
  }
}

/// Exception untuk 500 Server Error
class ServerException extends AppException {
  ServerException(super.message);
}

/// Exception untuk cache/local storage
class CacheException extends AppException {
  CacheException(super.message);
}
