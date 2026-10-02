import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/features/auth/data/models/auth_model.dart';
import 'package:plotline_mobile/features/auth/data/models/signin_user_req.dart';
import 'package:plotline_mobile/features/auth/data/models/signup_user_req.dart';
import 'package:plotline_mobile/features/auth/data/sources/auth_local_data_source.dart';
import 'package:plotline_mobile/features/auth/data/sources/auth_remote_data_source.dart';
import 'package:plotline_mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:plotline_mobile/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    final result = await sl<AuthRemoteDataSource>().signin(signinUserReq);

    return await result.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        final authModel = AuthModel.fromJson(data['data']);
        
        await sl<AuthLocalDataSource>().saveAuth(authModel);

        return Right(authModel);
      },
    );
  }

  @override
  Future<Either> signup(SignupUserReq signupUserReq) async {
    final result = await sl<AuthRemoteDataSource>().signup(signupUserReq);

    return await result.fold(
      (error) {
        return Left(error);
      },
      (data) async {
        final authModel = AuthModel.fromJson(data['data']);

        await sl<AuthLocalDataSource>().saveAuth(authModel);

        return Right(authModel);
      },
    );
  }
}
