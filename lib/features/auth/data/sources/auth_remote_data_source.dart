import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:plotline_mobile/core/configs/api/api_endpoints.dart';
import 'package:plotline_mobile/core/network/api_client.dart';
import 'package:plotline_mobile/features/auth/data/models/auth_model.dart';
import 'package:plotline_mobile/features/auth/domain/usecases/requests/signin_user_req.dart';
import 'package:plotline_mobile/features/auth/domain/usecases/requests/signup_user_req.dart';

abstract class AuthRemoteDataSource {
  Future<Either<String, AuthModel>> signin(SigninUserReq request);

  Future<Either<String, AuthModel>> signup(SignupUserReq request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  const AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<Either<String, AuthModel>> signin(SigninUserReq request) async {
    try {
      final response = await apiClient.dio.post(
        ApiEndpoints.signinUrl,
        data: {'email': request.email, 'password': request.password},
      );

      if (response.statusCode == 200) {
        return Right(_parseAuthResponse(response.data));
      }

      return Left(_messageFromResponse(response.data, 'Sign in failed'));
    } on DioException catch (e) {
      return Left(
        _messageFromResponse(e.response?.data, 'Something went wrong'),
      );
    } on FormatException catch (e) {
      return Left(e.message);
    }
  }

  @override
  Future<Either<String, AuthModel>> signup(SignupUserReq request) async {
    try {
      final response = await apiClient.dio.post(
        ApiEndpoints.signupUrl,
        data: {
          'firstName': request.firstName,
          'lastName': request.lastName,
          'email': request.email,
          'password': request.password,
          'dob': request.dob,
          'gender': request.gender,
        },
      );

      if (response.statusCode == 201) {
        return Right(_parseAuthResponse(response.data));
      }

      return Left(_messageFromResponse(response.data, 'Sign up failed'));
    } on DioException catch (e) {
      return Left(
        _messageFromResponse(e.response?.data, 'Something went wrong'),
      );
    } on FormatException catch (e) {
      return Left(e.message);
    }
  }

  AuthModel _parseAuthResponse(dynamic responseData) {
    if (responseData is! Map) {
      throw const FormatException('Invalid authentication response.');
    }

    final responseMap = Map<String, dynamic>.from(responseData);
    final data = responseMap['data'];

    if (data is! Map) {
      throw const FormatException(
        'Invalid authentication response: data is missing.',
      );
    }

    return AuthModel.fromJson(Map<String, dynamic>.from(data));
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
