import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/features/history/data/sources/history_remote_data_source.dart';
import 'package:plotline_mobile/features/history/domain/entity/history_result_entity.dart';
import 'package:plotline_mobile/features/history/domain/repository/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDataSource remoteDataSource;

  HistoryRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, HistoryResultEntity>> getHistory(
    String? userId,
    int page,
  ) async {
    final result = await remoteDataSource.getHistory(userId, page);

    return result.fold(
      (error) async => Left<String, HistoryResultEntity>(error),
      (history) async => Right<String, HistoryResultEntity>(history),
    );
  }
}
