import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:plotline_mobile/core/configs/api/api_endpoints.dart';
import 'package:plotline_mobile/core/network/api_client.dart';
import 'package:plotline_mobile/features/reviews/data/models/review_model.dart';

abstract class ReviewRemoteDataSource {
  Future<Either<String, List<ReviewModel>>> getMyReviews();

  Future<Either<String, List<ReviewModel>>> getFeedReviews();
}

class ReviewRemoteDataSourceImpl implements ReviewRemoteDataSource {
  final ApiClient apiClient;

  ReviewRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<Either<String, List<ReviewModel>>> getMyReviews() async {
    try {
      final response = await apiClient.dio.get(ApiEndpoints.myReviews);

      if (response.statusCode == 200) {
        final reviews = response.data['reviews'] as List<dynamic>;

        debugPrint('Response type: ${response.data.runtimeType}');
        debugPrint('Response data: ${response.data}');

        return Right(
          reviews
              .map(
                (review) => ReviewModel.fromJson(
                  Map<String, dynamic>.from(review as Map),
                ),
              )
              .toList(),
        );
      }

      return Left('Failed to fetch reviews');
    // } catch (error) {
    //   return Left(error.toString());
    } catch (e, stackTrace) {
      debugPrint('Reviews API failed: $e');
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<Either<String, List<ReviewModel>>> getFeedReviews() async {
    try {
      final response = await apiClient.dio.get(ApiEndpoints.feedReviews);

      if (response.statusCode == 200) {
        final reviews = response.data['feed'] as List<dynamic>;

        return Right(
          reviews
              .map(
                (review) => ReviewModel.fromJson(
                  Map<String, dynamic>.from(review as Map),
                ),
              )
              .toList(),
        );
      }

      return Left('Failed to fetch reviews');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
