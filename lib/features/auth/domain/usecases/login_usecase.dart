import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Use case untuk login
class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<AuthResponse> call(String email, String password) {
    return repository.login(email, password);
  }
}
