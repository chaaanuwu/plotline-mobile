import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/features/history/domain/entity/history_result_entity.dart';

abstract class HistoryRepository {
  Future<Either<String, HistoryResultEntity>> getHistory(
    String? userId,
    int page,
  );

  Future<Either<String, bool>> isInHistory(String movieId);
}
