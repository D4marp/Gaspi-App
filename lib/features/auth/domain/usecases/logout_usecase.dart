import '../repositories/auth_repository.dart';

/// Use case untuk logout
class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  Future<void> call() {
    return repository.logout();
  }
}
