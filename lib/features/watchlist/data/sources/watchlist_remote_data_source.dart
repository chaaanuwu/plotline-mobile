import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/core/configs/api/api_endpoints.dart';
import 'package:plotline_mobile/core/network/api_client.dart';
import 'package:plotline_mobile/features/watchlist/data/models/watchlist_model.dart';
import 'package:plotline_mobile/features/watchlist/domain/entity/watchlist_entity.dart';

abstract class WatchlistRemoteDataSource {
  Future<Either<String, List<WatchlistEntity>>> getWatchlist(String? userId);
}

class WatchlistRemoteDataSourceImpl implements WatchlistRemoteDataSource {
  final ApiClient apiClient;

  WatchlistRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<Either<String, List<WatchlistEntity>>> getWatchlist(
    String? userId,
  ) async {
    try {
      final req = userId == null
          ? ApiEndpoints.watchlist()
          : ApiEndpoints.watchlist(userId);

      final response = await apiClient.dio.get(req);

      if (response.statusCode == 200) {
        final watchlist = response.data['data'] as List<dynamic>;

        return Right(
          watchlist
              .map(
                (item) => WatchlistModel.fromJson(
                  Map<String, dynamic>.from(item as Map),
                ),
              )
              .toList(),
        );
      }

      return Left('Failed to fetch watchlist');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
