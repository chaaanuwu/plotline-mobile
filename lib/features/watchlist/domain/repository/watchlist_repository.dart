import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/features/watchlist/domain/entity/watchlist_result_entity.dart';

abstract class WatchlistRepository {
  Future<Either<String, WatchlistResultEntity>> getWatchlist(
    String? userId,
    int page,
  );
}
