import 'package:json_annotation/json_annotation.dart';
import '../../../../core/constants/user_role.dart';
import '../../domain/entities/user.dart';

part 'user_model.g.dart';

/// Model User untuk data layer (API response)
@JsonSerializable()
class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? phone;
  final String? avatar;
  @JsonKey(name: 'is_active')
  final bool isActive;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.phone,
    this.avatar,
    this.isActive = true,
  });

  /// Convert dari JSON
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Convert ke JSON
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  /// Convert model ke entity (domain)
  User toEntity() {
    return User(
      id: id,
      name: name,
      email: email,
      role: UserRole.fromString(role),
      phone: phone,
      avatar: avatar,
      isActive: isActive,
    );
  }

  /// Convert entity ke model
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role.value,
      phone: user.phone,
      avatar: user.avatar,
      isActive: user.isActive,
    );
  }
}

/// Model untuk Auth Response
@JsonSerializable()
class AuthResponseModel {
  final UserModel user;
  final String token;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  AuthResponseModel({
    required this.user,
    required this.token,
    required this.refreshToken,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);

  /// Convert ke entity
  AuthResponse toEntity() {
    return AuthResponse(
      user: user.toEntity(),
      token: token,
      refreshToken: refreshToken,
    );
  }
}

/// Model untuk Login Request
@JsonSerializable()
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
