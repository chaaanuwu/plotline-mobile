import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/features/reviews/domain/entity/review_entity.dart';

abstract class ReviewRepository {
  Future<Either<String, List<ReviewEntity>>> getMyReviews();
}
