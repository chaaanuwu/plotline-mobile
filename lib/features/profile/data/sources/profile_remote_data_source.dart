import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:plotline_mobile/core/configs/api/api_endpoints.dart';
import 'package:plotline_mobile/core/network/api_client.dart';
import 'package:plotline_mobile/features/profile/data/models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<Either<String, ProfileModel>> getMe();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient apiClient;

  ProfileRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<Either<String, ProfileModel>> getMe() async {
    try {
      final response = await apiClient.dio.get(ApiEndpoints.userMeProfile);

      if (response.statusCode == 200) {
        return Right(
          ProfileModel.fromJson(Map<String, dynamic>.from(response.data)),
        );
      }

      return Left(
        _messageFromResponse(response.data, 'Failed to get user data'),
      );
    } on DioException catch (e) {
      return Left(
        _messageFromResponse(e.response?.data, 'Something went wrong'),
      );
    }
  }

  String _messageFromResponse(dynamic data, String fallback) {
    if (data is Map) {
      final map = Map<String, dynamic>.from(data);
      final message = map['message'] ?? map['error'];

      if (message != null && message.toString().trim().isNotEmpty) {
        return message.toString();
      }
    }

    return fallback;
  }
}
