import 'package:plotline_mobile/features/profile/data/models/user_model.dart';
import 'package:plotline_mobile/features/profile/domain/entity/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.user,
    required super.followersCount,
    required super.followingCount,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      user: UserModel.fromJson(Map<String, dynamic>.from(json['user'])),
      followersCount: json['followersCount'] ?? 0,
      followingCount: json['followingCount'] ?? 0,
    );
  }
}
