import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/core/configs/api/api_endpoints.dart';
import 'package:plotline_mobile/core/network/api_client.dart';
import 'package:plotline_mobile/features/watchlist/data/models/watchlist_result_model.dart';
import 'package:plotline_mobile/features/watchlist/domain/entity/watchlist_result_entity.dart';

abstract class WatchlistRemoteDataSource {
  Future<Either<String, WatchlistResultEntity>> getWatchlist(
    String? userId,
    int page,
  );

  Future<Either<String, bool>> isInWatchlist(String movieId);
}

class WatchlistRemoteDataSourceImpl implements WatchlistRemoteDataSource {
  final ApiClient apiClient;

  WatchlistRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<Either<String, WatchlistResultEntity>> getWatchlist(
    String? userId,
    int page,
  ) async {
    try {
      final req = userId == null
          ? ApiEndpoints.watchlist()
          : ApiEndpoints.watchlist(userId);

      final response = await apiClient.dio.get(
        req,
        queryParameters: {'page': page},
      );

      if (response.statusCode == 200) {
        final result = WatchlistResultModel.fromJson(
          Map<String, dynamic>.from(response.data as Map),
        );

        return Right(result);
      }

      return Left('Failed to fetch watchlist');
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> isInWatchlist(String movieId) async {
    try {
      final response = await apiClient.dio.get(
        ApiEndpoints.isWatchlisted(movieId),
      );

      if (response.statusCode == 200) {
        return Right(response.data['watchListed']);
      }

      return Left('Failed to fetch watchlist');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
