import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/watchlist/domain/repository/watchlist_repository.dart';

class GetIsInWatchlistUsecase
    implements UseCase<Either<String, bool>, IsInWatchlistParams> {
  final WatchlistRepository repository;

  GetIsInWatchlistUsecase({required this.repository});

  @override
  Future<Either<String, bool>> call(IsInWatchlistParams params) {
    return repository.isInWatchlist(params.movieId);
  }
}

class IsInWatchlistParams {
  final String movieId;

  IsInWatchlistParams({required this.movieId});
}
