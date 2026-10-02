import 'package:plotline_mobile/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.dob,
    required super.gender,
    required super.about,
    required super.pfp,
    required super.cover,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      dob: json['dob'],
      gender: json['gender'],
      about: json['about'] ?? '',
      pfp: json['pfp'] ?? '',
      cover: json['cover'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'dob': dob,
      'gender': gender,
      'about': about,
      'pfp': pfp,
      'cover': cover,
    };
  }
}
