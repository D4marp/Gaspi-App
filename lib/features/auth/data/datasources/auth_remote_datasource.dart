import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_service.dart';
import '../models/user_model.dart';

/// Remote Data Source untuk Auth menggunakan API
class AuthRemoteDataSource {
  final ApiService _apiService;
  final bool _useMock;

  AuthRemoteDataSource(this._apiService, {bool useMock = true}) : _useMock = useMock;

  /// Login ke server
  Future<AuthResponseModel> login(String email, String password) async {
    // Mock mode untuk testing
    if (_useMock) {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));

      // Return mock data untuk setiap email
      if (email.toLowerCase().contains('admin')) {
        return AuthResponseModel(
          user: UserModel(
            id: '1',
            name: 'Admin User',
            email: email,
            role: 'admin',
            phone: '+62812345678',
            avatar: null,
            isActive: true,
          ),
          token: 'mock_token_admin_${DateTime.now().millisecondsSinceEpoch}',
          refreshToken: 'mock_refresh_token_admin_${DateTime.now().millisecondsSinceEpoch}',
        );
      } else if (email.toLowerCase().contains('super')) {
        return AuthResponseModel(
          user: UserModel(
            id: '2',
            name: 'Super Admin',
            email: email,
            role: 'super_admin',
            phone: '+62812345679',
            avatar: null,
            isActive: true,
          ),
          token: 'mock_token_superadmin_${DateTime.now().millisecondsSinceEpoch}',
          refreshToken: 'mock_refresh_token_superadmin_${DateTime.now().millisecondsSinceEpoch}',
        );
      } else if (email.toLowerCase().contains('maintenance')) {
        return AuthResponseModel(
          user: UserModel(
            id: '3',
            name: 'Maintenance Tech',
            email: email,
            role: 'maintenance',
            phone: '+62812345680',
            avatar: null,
            isActive: true,
          ),
          token: 'mock_token_maintenance_${DateTime.now().millisecondsSinceEpoch}',
          refreshToken: 'mock_refresh_token_maintenance_${DateTime.now().millisecondsSinceEpoch}',
        );
      } else if (email.toLowerCase().contains('supervisor')) {
        return AuthResponseModel(
          user: UserModel(
            id: '4',
            name: 'Supervisor',
            email: email,
            role: 'supervisor',
            phone: '+62812345681',
            avatar: null,
            isActive: true,
          ),
          token: 'mock_token_supervisor_${DateTime.now().millisecondsSinceEpoch}',
          refreshToken: 'mock_refresh_token_supervisor_${DateTime.now().millisecondsSinceEpoch}',
        );
      } else {
        // Default user (coordinator/staff)
        return AuthResponseModel(
          user: UserModel(
            id: '5',
            name: 'Test User',
            email: email,
            role: 'coordinator',
            phone: '+62812345682',
            avatar: null,
            isActive: true,
          ),
          token: 'mock_token_user_${DateTime.now().millisecondsSinceEpoch}',
          refreshToken: 'mock_refresh_token_user_${DateTime.now().millisecondsSinceEpoch}',
        );
      }
    }

    // Real API call
    final response = await _apiService.post(
      ApiEndpoints.login,
      data: LoginRequest(email: email, password: password).toJson(),
    );

    return AuthResponseModel.fromJson(response.data['data']);
  }

  /// Logout dari server
  Future<void> logout() async {
    if (_useMock) {
      await Future.delayed(const Duration(milliseconds: 500));
      return;
    }

    await _apiService.post(ApiEndpoints.logout);
  }

  /// Get user profile dari server
  Future<UserModel> getUserProfile() async {
    if (_useMock) {
      await Future.delayed(const Duration(milliseconds: 500));
      return UserModel(
        id: '1',
        name: 'Admin User',
        email: 'admin@gaspi.com',
        role: 'admin',
        phone: '+62812345678',
        avatar: null,
        isActive: true,
      );
    }

    final response = await _apiService.get(ApiEndpoints.profile);
    return UserModel.fromJson(response.data['data']);
  }

  /// Refresh token
  Future<AuthResponseModel> refreshToken(String refreshToken) async {
    if (_useMock) {
      await Future.delayed(const Duration(milliseconds: 500));
      return AuthResponseModel(
        user: UserModel(
          id: '1',
          name: 'Admin User',
          email: 'admin@gaspi.com',
          role: 'admin',
          phone: '+62812345678',
          avatar: null,
          isActive: true,
        ),
        token: 'mock_token_refresh_${DateTime.now().millisecondsSinceEpoch}',
        refreshToken: 'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
      );
    }

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
  // Set useMock to true for static testing, false for real API
  return AuthRemoteDataSource(apiService, useMock: true);
});
