import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';

part 'auth_provider.g.dart';

/// State untuk Authentication
class AuthState {
  final User? user;
  final bool isLoading;
  final String? error;
  final bool isAuthenticated;

  AuthState({
    this.user,
    this.isLoading = false,
    this.error,
    this.isAuthenticated = false,
  });

  AuthState copyWith({
    User? user,
    bool? isLoading,
    String? error,
    bool? isAuthenticated,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}

/// Auth Provider menggunakan Riverpod AsyncNotifier
@riverpod
class Auth extends _$Auth {
  @override
  Future<AuthState> build() async {
    // Check apakah user sudah login saat app start
    final repository = ref.read(authRepositoryProvider);
    final isLoggedIn = await repository.isLoggedIn();

    if (isLoggedIn) {
      final user = await repository.getCurrentUser();
      return AuthState(
        user: user,
        isAuthenticated: user != null,
      );
    }

    return AuthState();
  }

  /// Login function
  Future<void> login(String email, String password) async {
    // Set loading state
    state = const AsyncValue.loading();

    try {
      final repository = ref.read(authRepositoryProvider);
      final loginUseCase = LoginUseCase(repository);

      // Execute login
      final authResponse = await loginUseCase.call(email, password);

      // Update state dengan user data
      state = AsyncValue.data(
        AuthState(
          user: authResponse.user,
          isAuthenticated: true,
        ),
      );
    } catch (e, st) {
      // Set error state
      state = AsyncValue.error(e, st);
      
      // Tetap throw untuk handling di UI
      rethrow;
    }
  }

  /// Logout function
  Future<void> logout() async {
    state = const AsyncValue.loading();

    try {
      final repository = ref.read(authRepositoryProvider);
      final logoutUseCase = LogoutUseCase(repository);

      await logoutUseCase.call();

      // Clear state
      state = AsyncValue.data(AuthState());
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  /// Refresh user profile
  Future<void> refreshProfile() async {
    try {
      final repository = ref.read(authRepositoryProvider);
      final user = await repository.getUserProfile();

      state = AsyncValue.data(
        AuthState(
          user: user,
          isAuthenticated: true,
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

/// Provider untuk mendapatkan current user
@riverpod
User? currentUser(Ref ref) {
  final authState = ref.watch(authProvider);
  return authState.value?.user;
}

/// Provider untuk check authentication status
@riverpod
bool isAuthenticated(Ref ref) {
  final authState = ref.watch(authProvider);
  return authState.value?.isAuthenticated ?? false;
}
