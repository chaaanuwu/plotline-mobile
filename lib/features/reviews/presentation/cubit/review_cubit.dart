import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/reviews/domain/usecase/get_feed_reviews_usecase.dart';
import 'package:plotline_mobile/features/reviews/domain/usecase/get_my_reviews_usecase.dart';
import 'package:plotline_mobile/features/reviews/domain/usecase/get_user_reviews_usecase.dart';
import 'package:plotline_mobile/features/reviews/presentation/cubit/review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final GetMyReviewsUsecase getMyReviewsUsecase;
  final GetUserReviewsUsecase getUserReviewsUsecase;
  final GetFeedReviewsUsecase getFeedReviewsUsecase;

  ReviewCubit({
    required this.getMyReviewsUsecase,
    required this.getUserReviewsUsecase,
    required this.getFeedReviewsUsecase,
  }) : super(ReviewInitial());

  Future<void> getMyReviews() async {
    debugPrint('Fetching my reviews...');

    emit(ReviewLoading());

    final result = await getMyReviewsUsecase(NoParams());

    result.fold(
      (failure) {
        debugPrint('Reviews API failed: $failure');
        emit(ReviewError(failure));
      },
      (reviews) {
        debugPrint('Reviews fetched: ${reviews.length}');
        debugPrint('Reviews data: $reviews');

        emit(ReviewLoaded(reviews));
      },
    );
  }

  Future<void> getUserReviews(String userId) async {
    debugPrint('Fetching user reviews for: $userId');

    emit(ReviewLoading());

    final result = await getUserReviewsUsecase(userId);

    result.fold(
      (failure) {
        debugPrint('Reviews API failed: $failure');
        emit(ReviewError(failure));
      },
      (reviews) {
        debugPrint('Reviews fetched: ${reviews.length}');
        emit(ReviewLoaded(reviews));
      },
    );
  }

  Future<void> getFeedReviews() async {
    debugPrint('Fetching feed reviews...');

    emit(ReviewLoading());

    final result = await getFeedReviewsUsecase(NoParams());

    result.fold(
      (failure) {
        debugPrint('Reviews API failed: $failure');
        emit(ReviewError(failure));
      },
      (reviews) {
        debugPrint('Reviews fetched: ${reviews.length}');
        debugPrint('Reviews data: $reviews');

        emit(ReviewLoaded(reviews));
      },
    );
  }
}
