import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/core/configs/api/api_endpoints.dart';
import 'package:plotline_mobile/core/network/api_client.dart';
import 'package:plotline_mobile/features/history/data/models/history_result_model.dart';
import 'package:plotline_mobile/features/history/domain/entity/history_result_entity.dart';

abstract class HistoryRemoteDataSource {
  Future<Either<String, HistoryResultEntity>> getHistory(
    String? userId,
    int page,
  );
}

class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource {
  final ApiClient apiClient;

  HistoryRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<Either<String, HistoryResultEntity>> getHistory(
    String? userId,
    int page,
  ) async {
    try {
      final req = userId == null
          ? ApiEndpoints.history()
          : ApiEndpoints.history(userId);

      final response = await apiClient.dio.get(
        req,
        queryParameters: {'page': page},
      );

      if (response.statusCode == 200) {
        final result = HistoryResultModel.fromJson(
          Map<String, dynamic>.from(response.data as Map),
        );

        return Right(result);
      }

      return Left('Failed to fetch history');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
