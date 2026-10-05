import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/features/auth/domain/entity/auth_entity.dart';
import 'package:plotline_mobile/features/auth/data/requests/signin_user_req.dart';
import 'package:plotline_mobile/features/auth/data/requests/signup_user_req.dart';

abstract class AuthRepository {
  Future<Either<String, AuthEntity>> signin(SigninUserReq request);

  Future<Either<String, AuthEntity>> signup(SignupUserReq request);

  Future<Either<String, AuthEntity?>> getSavedAuth();

  Future<Either<String, void>> removeSavedAuth();
}
