import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/watchlist/domain/entity/watchlist_entity.dart';
import 'package:plotline_mobile/features/watchlist/domain/repository/watchlist_repository.dart';

class GetWatchlistUsecase
    implements UseCase<Either<String, List<WatchlistEntity>>, String> {
  final WatchlistRepository repository;

  GetWatchlistUsecase({required this.repository});

  @override
  Future<Either<String, List<WatchlistEntity>>> call(String? params) {
    return repository.getWatchlist(params);
  }
}
