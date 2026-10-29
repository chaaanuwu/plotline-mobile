import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/features/watchlist/domain/entity/watchlist_entity.dart';
import 'package:plotline_mobile/features/watchlist/domain/repository/watchlist_repository.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  @override
  Future<Either<String, List<WatchlistEntity>>> getWatchlist(String? userId) {
    // TODO: implement getWatchlist
    throw UnimplementedError();
  }

}