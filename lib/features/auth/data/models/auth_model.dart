import 'package:plotline_mobile/features/auth/data/models/user_model.dart';
import 'package:plotline_mobile/features/auth/domain/entity/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel({required super.token, required UserModel super.user});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'];

    if (userJson is! Map) {
      throw const FormatException(
        'Invalid authentication response: user is missing.',
      );
    }

    return AuthModel(
      token: json['token']?.toString() ?? '',
      user: UserModel.fromJson(Map<String, dynamic>.from(userJson)),
    );
  }

  Map<String, dynamic> toJson() {
    return {'token': token, 'user': (user as UserModel).toJson()};
  }
}
