import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/reviews/domain/entity/review_entity.dart';
import 'package:plotline_mobile/features/reviews/domain/repository/review_repository.dart';

class GetUserReviewsUsecase
    implements UseCase<Either<String, List<ReviewEntity>>, String> {
  final ReviewRepository repository;

  GetUserReviewsUsecase({required this.repository});

  @override
  Future<Either<String, List<ReviewEntity>>> call(String userId) {
    return repository.getUserReviews(userId);
  }
}
