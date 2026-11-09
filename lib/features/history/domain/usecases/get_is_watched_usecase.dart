import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/history/domain/repository/history_repository.dart';

class GetIsWatchedUsecase
    implements UseCase<Either<String, bool>, IsInHistoryParams> {
  final HistoryRepository repository;

  GetIsWatchedUsecase({required this.repository});

  @override
  Future<Either<String, bool>> call(IsInHistoryParams params) {
    return repository.isInHistory(params.movieId);
  }
}

class IsInHistoryParams {
  final String movieId;

  IsInHistoryParams({required this.movieId});
}
