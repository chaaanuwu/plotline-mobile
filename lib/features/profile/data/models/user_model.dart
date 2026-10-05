import 'package:plotline_mobile/features/profile/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.userId,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.dob,
    required super.gender,
    required super.about,
    required super.avatarUrl,
    required super.coverUrl,
    required super.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['_id']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      dob: json['dob']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      about: json['about']?.toString() ?? '',
      avatarUrl: json['pfp']?.toString() ?? '',
      coverUrl: json['cover']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
    );
  }
}
