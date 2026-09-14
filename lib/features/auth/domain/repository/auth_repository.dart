import 'package:dartz/dartz.dart';
import 'package:plotline_mobile/features/auth/data/models/signin_user_req.dart';

abstract class AuthRepository {
  Future<Either> signin(SigninUserReq signinUserReq);
}
