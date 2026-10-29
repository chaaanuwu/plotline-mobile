import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/watchlist/domain/entity/watchlist_result_entity.dart';
import 'package:plotline_mobile/features/watchlist/domain/repository/watchlist_repository.dart';

class GetWatchlistUsecase
    implements
        UseCase<Either<String, WatchlistResultEntity>, GetWatchlistParams> {
  final WatchlistRepository repository;

  GetWatchlistUsecase({required this.repository});

  @override
  Future<Either<String, WatchlistResultEntity>> call(
    GetWatchlistParams params,
  ) {
    return repository.getWatchlist(params.userId, params.page);
  }
}

class GetWatchlistParams {
  final String? userId;
  final int page;

  const GetWatchlistParams({this.userId, this.page = 1});
}
