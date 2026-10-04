import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/features/auth/domain/entity/auth_entity.dart';
import 'package:plotline_mobile/features/auth/domain/usecases/requests/signin_user_req.dart';
import 'package:plotline_mobile/features/auth/domain/usecases/requests/signup_user_req.dart';

abstract class AuthRepository {
  Future<Either<String, AuthEntity>> signin(SigninUserReq request);

  Future<Either<String, AuthEntity>> signup(SignupUserReq request);
}
