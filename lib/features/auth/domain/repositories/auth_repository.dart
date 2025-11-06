import '../entities/user.dart';

/// Repository interface untuk Auth
/// Mengikuti prinsip Dependency Inversion (Clean Architecture)
abstract class AuthRepository {
  /// Login dengan email dan password
  Future<AuthResponse> login(String email, String password);

  /// Logout
  Future<void> logout();

  /// Get current user dari local storage
  Future<User?> getCurrentUser();

  /// Check apakah user sudah login
  Future<bool> isLoggedIn();

  /// Refresh token
  Future<AuthResponse> refreshToken(String refreshToken);

  /// Get user profile dari server
  Future<User> getUserProfile();
}
