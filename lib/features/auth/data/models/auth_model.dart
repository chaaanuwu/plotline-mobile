import 'package:plotline_mobile/features/auth/domain/entity/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel({required super.token, required super.userId});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'];

    if (userJson is! Map) {
      throw const FormatException(
        'Invalid authentication response: user is missing.',
      );
    }

    return AuthModel(
      token: json['token']?.toString() ?? '',
      userId: userJson['_id']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'token': token, 'userId': userId};
  }
}
