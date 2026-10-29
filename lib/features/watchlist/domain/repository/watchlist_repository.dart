import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/features/watchlist/domain/entity/watchlist_entity.dart';

abstract class WatchlistRepository {
  Future<Either<String, List<WatchlistEntity>>> getWatchlist(String? userId);
}
