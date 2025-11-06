import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_service.dart';
import '../models/user_model.dart';

/// Remote Data Source untuk Auth menggunakan API
class AuthRemoteDataSource {
  final ApiService _apiService;

  AuthRemoteDataSource(this._apiService);

  /// Login ke server
  Future<AuthResponseModel> login(String email, String password) async {
    final response = await _apiService.post(
      ApiEndpoints.login,
      data: LoginRequest(email: email, password: password).toJson(),
    );

    return AuthResponseModel.fromJson(response.data['data']);
  }

  /// Logout dari server
  Future<void> logout() async {
    await _apiService.post(ApiEndpoints.logout);
  }

  /// Get user profile dari server
  Future<UserModel> getUserProfile() async {
    final response = await _apiService.get(ApiEndpoints.profile);
    return UserModel.fromJson(response.data['data']);
  }

  /// Refresh token
  Future<AuthResponseModel> refreshToken(String refreshToken) async {
    final response = await _apiService.post(
      ApiEndpoints.refreshToken,
      data: {'refresh_token': refreshToken},
    );

    return AuthResponseModel.fromJson(response.data['data']);
  }
}

/// Provider untuk AuthRemoteDataSource
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AuthRemoteDataSource(apiService);
});
