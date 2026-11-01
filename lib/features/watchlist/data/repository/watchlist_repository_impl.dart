import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/features/watchlist/data/sources/watchlist_remote_data_source.dart';
import 'package:plotline_mobile/features/watchlist/domain/entity/watchlist_result_entity.dart';
import 'package:plotline_mobile/features/watchlist/domain/repository/watchlist_repository.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistRemoteDataSource remoteDataSource;

  WatchlistRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, WatchlistResultEntity>> getWatchlist(
    String? userId,
    int page,
  ) async {
    final result = await remoteDataSource.getWatchlist(userId, page);

    return result.fold(
      (error) async => Left<String, WatchlistResultEntity>(error),
      (watchlist) async => Right<String, WatchlistResultEntity>(watchlist),
    );
  }

  @override
  Future<Either<String, bool>> isInWatchlist(String movieId) async {
    final result = await remoteDataSource.isInWatchlist(movieId);

    return result.fold(
      (error) async => Left<String, bool>(error),
      (isInWatchlist) => Right<String, bool>(isInWatchlist),
    );
  }
}
