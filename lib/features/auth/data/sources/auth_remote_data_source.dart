import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:plotline_mobile/core/configs/api/api_endpoints.dart';
import 'package:plotline_mobile/core/network/api_client.dart';
import 'package:plotline_mobile/features/auth/data/models/signin_user_req.dart';

abstract class AuthRemoteDataSource {
  Future<Either> signin(SigninUserReq signinUserReq);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    try {
      final response = await apiClient.dio.post(
        ApiEndpoints.signinUrl,
        data: {
          'email': signinUserReq.email,
          'password': signinUserReq.password,
        },
      );

      if (response.statusCode == 200) {
        return Right(response.data);
      }

      return Left('Sign in failed');
    } on DioException catch (e) {
      return Left(e.response?.data ?? 'Something went wrong');
    }
  }
}
