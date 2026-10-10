import 'package:plotline_mobile/features/reviews/domain/entity/review_movie_entity.dart';
import 'package:plotline_mobile/features/reviews/domain/entity/review_user_entity.dart';

class ReviewEntity {
  final String reviewId;
  final ReviewUserEntity user;
  final ReviewMovieEntity movie;
  final String reviewDescription;
  final List<String> likedBy;
  final DateTime createdAt;

  ReviewEntity({
    required this.reviewId,
    required this.user,
    required this.movie,
    required this.reviewDescription,
    required this.likedBy,
    required this.createdAt,
  });
}
