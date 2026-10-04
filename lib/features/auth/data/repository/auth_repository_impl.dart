import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/features/auth/data/sources/auth_local_data_source.dart';
import 'package:plotline_mobile/features/auth/data/sources/auth_remote_data_source.dart';
import 'package:plotline_mobile/features/auth/domain/entity/auth_entity.dart';
import 'package:plotline_mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:plotline_mobile/features/auth/domain/usecases/requests/signin_user_req.dart';
import 'package:plotline_mobile/features/auth/domain/usecases/requests/signup_user_req.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<String, AuthEntity>> signin(SigninUserReq request) async {
    final result = await remoteDataSource.signin(request);

    return await result.fold<Future<Either<String, AuthEntity>>>(
      (error) async => Left<String, AuthEntity>(error),
      (authModel) async {
        await localDataSource.saveAuth(authModel);
        return Right<String, AuthEntity>(authModel);
      },
    );
  }

  @override
  Future<Either<String, AuthEntity>> signup(SignupUserReq request) async {
    final result = await remoteDataSource.signup(request);

    return await result.fold<Future<Either<String, AuthEntity>>>(
      (error) async => Left<String, AuthEntity>(error),
      (authModel) async {
        await localDataSource.saveAuth(authModel);
        return Right<String, AuthEntity>(authModel);
      },
    );
  }
}
