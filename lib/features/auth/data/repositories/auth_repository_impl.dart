import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';

/// Implementasi AuthRepository
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<AuthResponse> login(String email, String password) async {
    // Call API
    final response = await remoteDataSource.login(email, password);

    // Save to local storage
    await localDataSource.saveToken(response.token);
    await localDataSource.saveRefreshToken(response.refreshToken);
    await localDataSource.saveUser(response.user);

    return response.toEntity();
  }

  @override
  Future<void> logout() async {
    // Call API (best effort, jangan throw error)
    try {
      await remoteDataSource.logout();
    } catch (e) {
      // Ignore error saat logout
    }

    // Clear local storage
    await localDataSource.clearAuth();
  }

  @override
  Future<User?> getCurrentUser() async {
    final userModel = await localDataSource.getUser();
    return userModel?.toEntity();
  }

  @override
  Future<bool> isLoggedIn() async {
    return await localDataSource.isLoggedIn();
  }

  @override
  Future<AuthResponse> refreshToken(String refreshToken) async {
    final response = await remoteDataSource.refreshToken(refreshToken);

    // Update token di local storage
    await localDataSource.saveToken(response.token);
    await localDataSource.saveRefreshToken(response.refreshToken);

    return response.toEntity();
  }

  @override
  Future<User> getUserProfile() async {
    final userModel = await remoteDataSource.getUserProfile();
    
    // Update local storage
    await localDataSource.saveUser(userModel);
    
    return userModel.toEntity();
  }
}

/// Provider untuk AuthRepository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  final localDataSource = ref.watch(authLocalDataSourceProvider);

  return AuthRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
});
