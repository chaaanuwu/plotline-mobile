import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/features/auth/data/models/signin_user_req.dart';
import 'package:plotline_mobile/features/auth/data/sources/auth_remote_data_source.dart';
import 'package:plotline_mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:plotline_mobile/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    return await sl<AuthRemoteDataSource>().signin(signinUserReq);
  }
}
