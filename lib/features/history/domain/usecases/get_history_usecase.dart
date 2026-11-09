import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/core/usecase/usecase.dart';
import 'package:plotline_mobile/features/history/domain/entity/history_result_entity.dart';
import 'package:plotline_mobile/features/history/domain/repository/history_repository.dart';

class GetHistoryUsecase
    implements UseCase<Either<String, HistoryResultEntity>, GetHistoryParams> {
  final HistoryRepository repository;

  GetHistoryUsecase({required this.repository});

  @override
  Future<Either<String, HistoryResultEntity>> call(GetHistoryParams params) {
    return repository.getHistory(params.userId, params.page);
  }
}

class GetHistoryParams {
  final String? userId;
  final int page;

  const GetHistoryParams({this.userId, this.page = 1});
}
