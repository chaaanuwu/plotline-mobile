import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/features/reviews/data/sources/review_remote_data_source.dart';
import 'package:plotline_mobile/features/reviews/domain/entity/review_entity.dart';
import 'package:plotline_mobile/features/reviews/domain/repository/review_repository.dart';

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewRemoteDataSource remoteDataSource;

  ReviewRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, List<ReviewEntity>>> getMyReviews() async {
    final result = await remoteDataSource.getMyReviews();

    return result.fold(
      (error) async => Left<String, List<ReviewEntity>>(error),
      (reviews) async => Right<String, List<ReviewEntity>>(reviews),
    );
  }

  @override
  Future<Either<String, List<ReviewEntity>>> getFeedReviews() async {
    final result = await remoteDataSource.getFeedReviews();

    return result.fold(
      (error) async => Left<String, List<ReviewEntity>>(error),
      (reviews) async => Right<String, List<ReviewEntity>>(reviews),
    );
  }
}
