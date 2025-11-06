import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/user_model.dart';

/// Local Data Source untuk Auth (Storage)
class AuthLocalDataSource {
  final FlutterSecureStorage _secureStorage;
  final SharedPreferences _prefs;

  AuthLocalDataSource(this._secureStorage, this._prefs);

  /// Save token ke secure storage
  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: AppConstants.keyToken, value: token);
  }

  /// Save refresh token
  Future<void> saveRefreshToken(String refreshToken) async {
    await _secureStorage.write(
      key: AppConstants.keyRefreshToken,
      value: refreshToken,
    );
  }

  /// Get token
  Future<String?> getToken() async {
    return await _secureStorage.read(key: AppConstants.keyToken);
  }

  /// Get refresh token
  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: AppConstants.keyRefreshToken);
  }

  /// Save user data
  Future<void> saveUser(UserModel user) async {
    await _prefs.setString(AppConstants.keyUserData, jsonEncode(user.toJson()));
    await _prefs.setString(AppConstants.keyUserId, user.id);
    await _prefs.setString(AppConstants.keyUserRole, user.role);
  }

  /// Get user data
  Future<UserModel?> getUser() async {
    final userJson = _prefs.getString(AppConstants.keyUserData);
    if (userJson == null) return null;

    return UserModel.fromJson(jsonDecode(userJson));
  }

  /// Clear all auth data
  Future<void> clearAuth() async {
    await _secureStorage.delete(key: AppConstants.keyToken);
    await _secureStorage.delete(key: AppConstants.keyRefreshToken);
    await _prefs.remove(AppConstants.keyUserData);
    await _prefs.remove(AppConstants.keyUserId);
    await _prefs.remove(AppConstants.keyUserRole);
  }

  /// Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}

/// Provider untuk AuthLocalDataSource
final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  throw UnimplementedError('Harus di-override di main.dart');
});
