import 'package:plotline_mobile/features/reviews/domain/entity/review_user_entity.dart';

class ReviewUserModel extends ReviewUserEntity {
  ReviewUserModel({
    required super.userId,
    required super.firstName,
    required super.lastName,
    required super.avatar,
  });

  factory ReviewUserModel.fromJson(Map<String, dynamic> json) {
    return ReviewUserModel(
      userId: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      avatar: json['pfp'],
    );
  }
}
