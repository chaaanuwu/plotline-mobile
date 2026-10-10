import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/reviews/domain/entity/review_entity.dart';
import 'package:plotline_mobile/features/reviews/domain/repository/review_repository.dart';

class GetMyReviewsUsecase
    implements UseCase<Either<String, List<ReviewEntity>>, NoParams> {
  final ReviewRepository repository;

  GetMyReviewsUsecase({required this.repository});

  @override
  Future<Either<String, List<ReviewEntity>>> call(NoParams params) {
    return repository.getMyReviews();
  }
}
