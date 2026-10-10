import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/reviews/domain/entity/review_entity.dart';
import 'package:plotline_mobile/features/reviews/domain/repository/review_repository.dart';

class GetFeedReviewsUsecase implements UseCase<Either<String, List<ReviewEntity>>, NoParams> {
  final ReviewRepository repository;

  GetFeedReviewsUsecase({required this.repository});

  @override
  Future<Either<String, List<ReviewEntity>>> call(NoParams params) {
    return repository.getFeedReviews();
  }
}