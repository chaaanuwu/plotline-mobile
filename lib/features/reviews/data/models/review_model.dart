import 'package:plotline_mobile/features/reviews/data/models/review_movie_model.dart';
import 'package:plotline_mobile/features/reviews/data/models/review_user_model.dart';
import 'package:plotline_mobile/features/reviews/domain/entity/review_entity.dart';

class ReviewModel extends ReviewEntity {
  ReviewModel({
    required super.reviewId,
    required super.user,
    required super.movie,
    required super.reviewDescription,
    required super.likedBy,
    required super.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      reviewId: json['_id'],
      user: ReviewUserModel.fromJson(Map<String, dynamic>.from(json['userId'])),
      movie: ReviewMovieModel.fromJson(
        Map<String, dynamic>.from(json['movieId']),
      ),
      reviewDescription: json['review'],
      likedBy: List<String>.from(json['likedBy'] ?? []),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
