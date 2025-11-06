import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';
import '../errors/app_exception.dart';

/// Provider untuk Dio instance
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(milliseconds: AppConstants.connectTimeout),
      receiveTimeout: const Duration(milliseconds: AppConstants.receiveTimeout),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Interceptor untuk logging
  dio.interceptors.add(LogInterceptor(
    request: true,
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
    responseBody: true,
    error: true,
  ));

  // Interceptor untuk authentication
  dio.interceptors.add(AuthInterceptor(ref));

  // Interceptor untuk error handling
  dio.interceptors.add(ErrorInterceptor());

  return dio;
});

/// Interceptor untuk menambahkan token ke setiap request
class AuthInterceptor extends Interceptor {
  final Ref ref;

  AuthInterceptor(this.ref);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Ambil token dari secure storage
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: AppConstants.keyToken);

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}

/// Interceptor untuk menangani error global
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final appException = _handleError(err);
    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: appException,
        type: err.type,
      ),
    );
  }

  AppException _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkException('Koneksi timeout. Silakan coba lagi.');

      case DioExceptionType.badResponse:
        return _handleStatusCode(error.response?.statusCode, error.response?.data);

      case DioExceptionType.cancel:
        return AppException('Request dibatalkan');

      case DioExceptionType.connectionError:
        return NetworkException('Tidak ada koneksi internet');

      default:
        return AppException('Terjadi kesalahan: ${error.message}');
    }
  }

  AppException _handleStatusCode(int? statusCode, dynamic data) {
    final message = data is Map ? data['message'] ?? data['error'] : null;

    switch (statusCode) {
      case 400:
        return BadRequestException(message ?? 'Request tidak valid');
      case 401:
        return UnauthorizedException(message ?? 'Sesi anda telah berakhir');
      case 403:
        return ForbiddenException(message ?? 'Akses ditolak');
      case 404:
        return NotFoundException(message ?? 'Data tidak ditemukan');
      case 422:
        return ValidationException(message ?? 'Validasi gagal', data);
      case 500:
      case 502:
      case 503:
        return ServerException(message ?? 'Server error. Silakan coba lagi');
      default:
        return AppException(message ?? 'Terjadi kesalahan');
    }
  }
}
