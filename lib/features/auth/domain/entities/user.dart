import 'package:equatable/equatable.dart';
import '../../../../core/constants/user_role.dart';

/// Entity User untuk domain layer
class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final String? phone;
  final String? avatar;
  final bool isActive;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.phone,
    this.avatar,
    this.isActive = true,
  });

  @override
  List<Object?> get props => [id, name, email, role, phone, avatar, isActive];
}

/// Entity untuk Auth Response
class AuthResponse extends Equatable {
  final User user;
  final String token;
  final String refreshToken;

  const AuthResponse({
    required this.user,
    required this.token,
    required this.refreshToken,
  });

  @override
  List<Object> get props => [user, token, refreshToken];
}
