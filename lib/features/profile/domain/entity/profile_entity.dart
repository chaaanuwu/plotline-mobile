import 'package:plotline_mobile/features/profile/domain/entity/user_entity.dart';

class ProfileEntity {
  final UserEntity user;
  final int followersCount;
  final int followingCount;

  const ProfileEntity({
    required this.user,
    required this.followersCount,
    required this.followingCount,
  });
}
