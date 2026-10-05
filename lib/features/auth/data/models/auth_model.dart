import 'package:plotline_mobile/features/auth/domain/entity/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel({required super.token, required super.userId});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['token']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'token': token, 'userId': userId};
  }
}
